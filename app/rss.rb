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
		.where(:source=>source)
		.order(:mixed)
		.uniq(:title)[0..4]						
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


def any_sources_not_fetched_via_RSS_today?
	@not_yet_fetched = []
	CURRENT_NAMES.each do |key|
		fetched = Story.where(:source=>key).last.date.formatted_date == Date.today.to_s
		@not_yet_fetched << key if not fetched
	end
	@not_yet_fetched
end

def process_new_stories_by_source(titles, key)

	story_array = []
	mixed_scores = []
	titles[0..9].each do |item| 
		params = {
			:title=> item.title.strip.gsub("&apos;","'"),
			:source =>key.downcase,
			:date=> Time.now,
			:mixed=>0.0,
			:afinn=>0.0,
			:wiebe=>0.0 
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


def get_todays_rss(options={:papers=>[]})

	todays_data = [$current_time_formatted]
	todays_stories = {}
	threads = []
	$offline = false
	$parsererror = false
	options[:papers] ? sources = options[:papers] : sources = CURRENT_NAMES

	sources.each do |key|
		key = key.titleize
		feedUrl = SOURCES[key]
		p "fetching #{key} RSS: #{feedUrl}"

		begin

			unless $offline
				rss = open(feedUrl).read
				feed = RSS::Parser.parse(rss,false)
				data = feed.items
				story_array, @mixed_scores = process_new_stories_by_source(data, key)
			end

		rescue SocketError => e 

			p "#{e} at #{Time.now}: #{key}"
			$offline=true

		rescue RSS::NotWellFormedError => e

			p "#{e} at #{Time.now}: #{key}"
			$parsererror=true
					
		end

		if $offline
			# records = Story.where(source:key).order('date DESC').limit(10)
			# $grimmest_articles_today[key] = records.negative.order(:mixed)
			# mixed_normalized = records.get_average(:mixed).round(2)
			next
		elsif $parsererror

			# email me TO DO!
			next
		else
			# todays_stories[key] = story_array.sort{|a,b|a[:mixed]<=>b[:mixed]}.select{|a|a[:mixed]<0}
			mixed_normalized = get_average(@mixed_scores).round(2)
			save_scores(key,mixed_normalized) #save data to AR
		end

		p "finishing #{key} RSS: #{feedUrl}"
	end
end

def check_and_fetch_today_if_needed
	  to_be_fetched = any_sources_not_fetched_via_RSS_today?
	  if to_be_fetched
	      p "getting RSS"  
	      set_up_sentiment_analysers 
	      get_todays_rss(options={:papers=>to_be_fetched})
	  end
end



