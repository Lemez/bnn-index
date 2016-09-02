require 'httparty' 
require 'rss'
# require 'dropbox_sdk'
Dir[File.dirname(__FILE__) + '../models/*'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*_methods.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/analysers.rb'].each {|file| require file }
require 'csv'
require 'date'
require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'pry'
# require 'user_agent_randomizer'
require 'lemmatizer'

def check_fetch_update_today_if_needed
	  day = Date.today.to_s

	  stories_to_be_fetched = any_sources_not_fetched_via_RSS_today?(day)
	  if stories_to_be_fetched.any?

	      set_up_sentiment_analysers

	      stories_to_be_fetched.each do |params|
	      	get_todays_rss(options=params)
		 	create_or_update_score_for(params[:name],day)
		  end
	 end

	 create_or_update_dailyscore_for(day)

end

def any_sources_not_fetched_via_RSS_today? (day)

	@not_yet_fetched = []
	CURRENT_NAMES.each do |key|

		params = {:name=> key, :got=>0}

		got_today = Story.count_stories_on(key,day)

		if got_today < DAILY_NUMBER
			params[:got] = got_today
			@not_yet_fetched << params
			p params
		end
	end
	@not_yet_fetched
end



def get_reset_date
	RACK_ENV == 'production' ? Date.parse("2016-08-25") : Date.parse("2016-07-30")
end

def get_starting_date	
	Story.first.date
end


def destroy_all_today
	Story.from_today.destroy_all
	Score.from_today.destroy_all
	DailyScore.from_today.destroy_all
end


def process_new_stories_by_source(data, key,type, options)

	data.reject!{|d| d.date.to_date != Date.today}
	story_array = []
	mixed_scores = []
	data.each do |item| 

		 if type=='RSS' 
		 	processed_title = item.title
		 else 
		 	processed_title = item
		 end

		params = {
			:title=> processed_title.strip.gsub("&apos;","'"),
			:source =>key.downcase,
			:date=> Time.now,
			:mixed=>0.0,
			:afinn=>0.0,
			:wiebe=>0.0,
			:method=>type 
		}

		#  combination of AFINN and WIEBE is by far best with least outliers
		analysis_data = params[:title].get_all_word_scores

		params[:afinn] = analysis_data[:afinn_aggregate]
		params[:wiebe] = analysis_data[:wiebe_aggregate]
		params[:mixed] = 0.0 - 
						analysis_data[:shouts] +
						((params[:afinn]+params[:wiebe])/2) 

		if enough_stories_for_source_already_saved_today?(params)
			p "#{DAILY_NUMBER} Saved stories from #{key} today"
			return

		elsif story_not_yet_saved?(params)
			save_stories(params) 

		else
			p "EXISTS: #{params[:source]}: #{params[:title]} saved previously on #{Story.where(:title=>params[:title]).first.date.formatted_date}"
		end
	end
end


def any_sources_not_updated_today?
	missing = []
	allsources = SOURCES.keys.map(&:downcase)
	allsources.each {|s| missing << s if Story.all.source_not_updated_today?(s)}

	missing
end


def get_todays_rss(options={:name=>'',:got=>0})

	method = "RSS"
	todays_data = [$current_time_formatted]
	todays_stories = {}
	threads = []
	$online = true
	$parsererror = false
	$servererror = false

	key = options[:name].titleize
	feedUrl = SOURCES[key]
	p "fetching #{key} RSS: #{feedUrl}"

	begin

		if $online
			rss = open(feedUrl).read
			feed = RSS::Parser.parse(rss,false)
			data = feed.items
			process_new_stories_by_source(data, key, method,options)
		end

	rescue SocketError => e 

		p "#{e} at #{Time.now}: #{key}"
		$online=false

	rescue RSS::NotWellFormedError => e

		p "#{e} at #{Time.now}: #{key}"
		$parsererror=true

	rescue OpenURI::HTTPError => e
		p "#{e} at #{Time.now}: #{key}"
		$servererror=true
				
	end

	if $parsererror || $servererror
		# email me TO DO!
		
	end

	p "finishing #{key} RSS: #{feedUrl}"

end







def check_and_get_missing_sources
	 missing = any_sources_not_updated_today?

	 if missing.any?
	  	scrape_instead(missing)
	 end
end



def get_random_ua
	UserAgentRandomizer::UserAgent.fetch
end

def scrape_instead(source_array)

	method = "bing"

	source_array.each do |source|
		agent = get_random_ua
		page = HTTParty.get(SCRAPERS[source], headers: {"User-Agent" => agent.string})
		doc = Nokogiri::HTML(page)

		data = []

		doc.search("a[@class='title']").each do |row|
			item = {}
			item[:title] = row.content
			data << item
		end

		process_new_stories_by_source(data,source, method)
		
		# save_scores(source,Date.today.to_s)
	end
end



