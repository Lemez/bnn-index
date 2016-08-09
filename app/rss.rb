require 'httparty' 
require 'rss'
require 'dropbox_sdk'
Dir.glob('../models/*', &method(:require_relative))
require 'csv'
require 'date'
require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'pry'
require_relative './analysers.rb'
require 'user_agent_randomizer'


def save_scores(paper,score)
									#ensures only one per paper per day
	Score.where(date:$current_time, source:paper).first_or_create do |sc|
		sc.score = score
		# need to sc.update ?
	end
end

def get_todays_saved_story_objects(options = {:date => date})

	grimmest_stories_saved_from_today = {}
	day = options[:date]

	CURRENT_NAMES.each do |source|
		grimmest_stories_saved_from_today[source] = Story.all
		.from_day(day)
		.uniq(:title)
		.where(:source=>source)
		.order(:mixed)
		.limit(5)						
	end

	grimmest_stories_saved_from_today

end

def story_not_yet_saved? (params)
	Story.where(:title=>params[:title]).empty?
end


def save_stories(storyparams)

	st = Story.create(storyparams)
	st.save!
	p "SAVING: #{storyparams[:title]} is new" if st.persisted?

end


def process_new_stories_by_source(data, key,type, options)

	story_array = []
	mixed_scores = []
	got = options[:got]
	amount = DAILY_NUMBER - 1
	starting,ending = got,got+amount

	data[starting..ending].each do |item| 

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

		# params[:afinn] = params[:title].afinn_probability.round(2)*100
		# params[:wiebe] = params[:title].wiebe_probability.round(2)*100
		# params[:mixed] = (params[:afinn]+params[:wiebe])/2
		mixed_scores << params[:mixed]

		if story_not_yet_saved?(params)
			save_stories(params) 

		else
			p "EXISTS: #{params[:source]}: #{params[:title]} saved previously on #{Story.where(:title=>params[:title]).first.date.formatted_date}"

		end

		story_array << params

	end

	[story_array,mixed_scores]
	
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

		story_array,@mixed_scores = process_new_stories_by_source(data,source, method)

		mixed_normalized = get_average(@mixed_scores).round(2)
		save_scores(source,mixed_normalized) #save data to AR
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
			story_array, @mixed_scores = process_new_stories_by_source(data, key, method,options)
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
	else
		# todays_stories[key] = story_array.sort{|a,b|a[:mixed]<=>b[:mixed]}.select{|a|a[:mixed]<0}
		mixed_normalized = get_average(@mixed_scores).round(2)
		save_scores(key,mixed_normalized) #save data to AR
	end

	p "finishing #{key} RSS: #{feedUrl}"

end

def check_and_fetch_today_if_needed
	  to_be_fetched = any_sources_not_fetched_via_RSS_today?
	  if to_be_fetched.any?
	      p "getting RSS"  
	      set_up_sentiment_analysers 
	      to_be_fetched.each {|params|get_todays_rss(options=params)}
	 end

	 # check_and_get_missing_sources
end

def any_sources_not_fetched_via_RSS_today?

	@not_yet_fetched = []
	CURRENT_NAMES.each do |key|

		params = {:name=> key, :got=>0}

		got_today = Story.count_todays_stories(key)

		if got_today < DAILY_NUMBER
			params[:got] = got_today
			@not_yet_fetched << params
			p params
		end
	end
	@not_yet_fetched
end

def check_and_get_missing_sources
	 missing = any_sources_not_updated_today?

	 if missing.any?
	  	scrape_instead(missing)
	 end
end



