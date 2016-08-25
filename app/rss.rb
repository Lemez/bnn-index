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
require 'lemmatizer'


def destroy_all_today
	Story.from_today.destroy_all
	Score.from_today.destroy_all
	DailyScore.from_today.destroy_all
end

def save_scores(paper,score)
									#ensures only one per paper per day
	Score.from_today.find_or_create_by(source:paper) do |sc|
		sc.date = $current_time
		sc.score = score
		# need to sc.update ?
	end
end

def get_todays_saved_story_objects(options = {:date => date})

	grimmest = {}

	CURRENT_NAMES.each do |source|
		$passed = []
		stories = Story.all
		.from_day(options[:date])
		.uniq(:title)
		.where(:source=>source)
		.order(:mixed)
		.select{|a| a.is_uniqish_by_tfidf(source)}
		# .select{|a| a.is_uniqish(source)}

		grimmest[source] = stories[0..4]

	end

	grimmest
end

def get_scoring_words_from_grimmest
	
	lem = Lemmatizer.new
	results={}
	$grimmest_articles_today.each_pair do |k,v|
	    v.each do |story|
	    	storytmp = {}
	      	story.title.split(" ").each_with_index do |w,index|

	      		w = w.gsub(/[^[:alnum:]]/, "")
	      		next if $erratum_list.include?(w)

	      		word = lem.lemma(w.downcase)
	      		shouting = w.is_shouting?(word)

		      	afinnscore=$afinn[word]
			 	afinnscore.nil? ? afinnscore=0 : afinnscore=afinnscore.round(2)

			 	wiebescore=$wiebe[word]
		 		wiebescore.nil? ? wiebescore=0 : wiebescore=wiebescore[:sentiment]

		        storytmp[index] = {'score'=>afinnscore + wiebescore, 'shouting'=> shouting}

	        end

	        results[story.id] = storytmp
	    end
	end

	p results
	results
end


def story_not_yet_saved? (params)
	Story.where(:title=>params[:title]).empty?
end

def enough_stories_for_source_already_saved_today?(params)
	Story.from_today.where(source:params[:source]).count == DAILY_NUMBER
end


def save_stories(storyparams)

	st = Story.create(storyparams)
	st.save!
	p "SAVING: #{storyparams[:title]} is new" if st.persisted?

end

def update_story(params)

	s = Story.find(params[:id])
	p "#{s.id}, #{s.date}, #{s.source}, #{s.title}" 

	old = s.mixed
	s.update(params)

	p "Old: #{old} New: #{params[:mixed]}, #{s.title}" if s.persisted?

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
		@mixed_scores = Story.from_today.where(source:source).map(&:mixed)

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
	else
		@mixed_scores = Story.from_today.where(source:options[:name]).map(&:mixed)
		save_scores(options[:name], get_average(@mixed_scores).round(2)) 
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

def recalculate_story_score_since(day)
	Story.since_day(day).each do |s|

		analysis_data = s.title.get_all_word_scores

		params = {
			:title=> s.title,
			:id => s.id,
			:source =>s.source,
			:date=> s.date,
			:mixed=>0.0,
			:afinn=>analysis_data[:afinn_aggregate],
			:wiebe=>analysis_data[:wiebe_aggregate],
			:method=>s.method 
		}

		params[:mixed] = 0.0 - 
						analysis_data[:shouts] +
						((params[:afinn]+params[:wiebe])/2) 

		update_story(params) unless s.mixed==params[:mixed]

	end

end



