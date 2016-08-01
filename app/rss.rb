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

	SOURCES.keys.map(&:downcase).each do |source|
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

	Story.where(source: storyparams[:source],title: storyparams[:title]).first_or_create do |st|
		st.update(storyparams)
		st.save!
	end


end

def already_fetched_RSS_today?
	Story.last.formatted_date == Date.today.to_s
end

def process_new_stories_by_source(data, key)

	story_array = []
	mixed_scores = []
	data[0..9].each do |item| 
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
			p "SAVING: #{params[:title]} is new"
		else
			p "EXISTS: #{params[:title]} saved previously"
		end

		story_array << params

	end

	[story_array,mixed_scores]
	
end


def get_todays_rss

	todays_data = [$current_time_formatted]
	todays_stories = {}
	threads = []
	$offline = false
	$parsererror = false

	SOURCES.each_pair do |key,v|
		p "fetching #{key} RSS: #{v}"

		begin

			unless $offline
				rss = open(v).read
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
			# mixed_normalized = records.average(:mixed).round(2)
			next
		elsif $parsererror

			# email me TO DO!
			next
		else
			# todays_stories[key] = story_array.sort{|a,b|a[:mixed]<=>b[:mixed]}.select{|a|a[:mixed]<0}
			mixed_normalized = average(@mixed_scores).round(2)
			save_scores(key,mixed_normalized) #save data to AR
		end

		p "finishing #{key} RSS: #{v}"
	end
end

def make_new_csv (olddata,newdata)
	@new_csv = CSV.open("new.csv", "wb") do |csv|
		olddata.each do |line|
			csv << line
		end
		csv << newdata
	end
end


def save_to_dropbox(dataToAdd)

	p "saving to DropBox"

	access_token = DB_ACCESS
	client = DropboxClient.new(access_token)
	location, name = '/Public',"papers_production.csv"
	result = client.search(location, name)[0]
	contents, metadata = client.get_file_and_metadata(result['path'])

	@current = CSV.parse(contents)
	make_new_csv @current,dataToAdd.split(",")

	newfile = open("new.csv")
	response = client.put_file(result['path'], newfile, overwrite=true, parent_rev=nil)
	puts "uploaded:", response.inspect


end

