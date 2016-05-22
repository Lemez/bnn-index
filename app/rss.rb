require 'httparty' 
require 'rss'
require 'dropbox_sdk'
Dir.glob('../models/*', &method(:require_relative))
require 'csv'
require 'sentimentalizer'
require 'date'
require 'nokogiri'
require 'open-uri'
require 'pry'


def set_up_sentiment_analysers
	# Sentimentalizer.setup
	p "setting up afinn"
	afinn_to_hash
	p "afinn done"
	p "----"
	p "setting up wiebe"
	wiebe_to_hash
	p "wiebe done"
	p "----"
end

def write_stories_title_to_file
	 file = File.open("test.txt","w")
	    Story.all.each do |s|
	      file.puts(s.title)
	    end
    file.close
end

def analyse_headlines_with_brown

	clusters = [10,20,40,60,80,100,120,150,200,500,1000]
	clusters.each do |x|
		`./wcluster --text test.txt --c #{x}`
	end

	# https://github.com/percyliang/brown-cluster

	# http://www.derczynski.com/sheffield/brown-tuning/
	# Low cluster counts and small input corpora both lead to poor quality Brown clusterings. But this isn't very useful general advice. We need to look deeper. We'll change to recognising named entities in news text, because we have bigger and more reliable data in this area, which improves the stability and resolution of the performance scores.
	
end

def analyse_brown_output
	 hash = {}
        Dir.glob("./lib/brown-cluster/*.out/paths").each do |file|
            f = File.dirname(file)
            write = File.open("#{f}/readable.txt","w")
            File.open(file,"r").readlines.each do |line, line_num|

                binary,word,group = line.split("\t")
                group.strip!
                word.strip!

                if !hash.has_key?(group)
                  hash[group] = [word]
                else
                  arr = hash[group]
                  arr << word
                  hash[group] = arr
                end
            end

            hash.each_pair do |k,v|
              write.puts(k)
              write.printf("#{v}\n\n")
            end
            write.close
        end
end

def afinn_to_hash
	$afinn = {}
	IO.foreach(Padrino.root("public", "AFINN-111.txt")) do |x|
		word, score = x.split(",")
		$afinn[word]=score.strip.to_i 
	end
end

def wiebe_to_hash
	$wiebe = {}
	IO.foreach(Padrino.root("public", "subjectivity_lexicon_opinion_finder.txt")) do |x|
		t={:pos=>'',:sentiment=>0}

		sentiment = 0
		strength,word,t[:pos],sentiment_word = x.split(" ")

		case sentiment_word.strip
		when "positive"
			sentiment=1.0
		when "negative"
			sentiment=-1.0
		end

		case strength
		when "weaksubj"
			t[:sentiment]=sentiment/2
		else
			t[:sentiment]=sentiment
		end

		$wiebe[word]= t
	end
end


def average(sequence)  
  sequence.inject(:+).to_f / sequence.length  
end  

def save_scores(paper,score)

	Score.where(date:@current_time, source:paper).first_or_create do |sc|
		sc.score = score
	end

	#ensures only one per paper per day
end

def get_todays_saved_stories

	@titles_today = {}
	SOURCES.keys.each do |source|

		@titles_today[source] = Story.all
									.find_by_source(source)
									.on_date(Time.now.formatted_date)
									.uniq{|a| a.title}
									.map(&:title)
	end
end

def story_already_saved? (params)
	source = params[:source]

	@titles_today[source].include?(params[:title])
end

def add_title_to_saved (params)
	@titles_today[params[:source]] << params[:title]

	p "added #{params[:title]} to #{params[:source]}"
end

def save_stories(storyparams)

	Story.where(source: storyparams[:source],title: storyparams[:title]).first_or_create do |st|
		st.update(storyparams)
		st.save!
	end

	add_title_to_saved(storyparams)

end

def already_fetched_RSS_today?

	Story.last.formatted_date == Date.today.to_s

end


def get_todays_rss

	todays_data = [@current_time_formatted]
	todays_stories = {}
	threads = []
	@offline=false

	get_todays_saved_stories

	SOURCES.each_pair do |k,v|
		# threads << Thread.new(k) {|key|

				key = k unless key

				p "fetching #{key} RSS: #{v}"
				
				story_array = []
				begin

					rss = open(v).read
					feed = RSS::Parser.parse(rss,false)
					data = feed.items

				rescue SocketError #when there are connection problems
					p "SOCKET ERROR #{Time.now}"
					data = Story.where(source:key).order(:date)[0..9]
					@offline=true

				rescue RSS::NotWellFormedError #when it is not xml format
					p "Fetching alternative data"

					data = Story.where(source:key).order(:date)[0..9]

					# if k == "Times"
					# 	response = HTTParty.get("#{v}")
					#      doc = Nokogiri::XML(response)

					# 	doc.css('div.rss-list ul li a').each do |link|

					# 		title = link.content.gsub(/[^\p{Space}\p{Word}-]/, '')

					# 		# make a new object that mimics the RSS library to enable it to parse the Times data in the same way
					# 		story = ItemKlass.new
					# 		story.title = title

					# 		data << story
					# 	end

					# # else
					# # 	data = Story.where(source:key).order(:date)[0..9]
					# end

				end
				afinn_scores,wiebe_scores,mixed_scores = [],[],[]

				data.each.with_index do |item,i| 
					if i<10
						params = {:title=> '', :date=> Time.now, :mixed=>0.0, :afinn=>0.0, :wiebe=>0.0, :source =>'' }
						params[:title] = item.title.strip.gsub("&apos;","'")
						params[:afinn] = params[:title].afinn_probability.round(2)*100
						params[:wiebe] = params[:title].wiebe_probability.round(2)*100
						params[:source]=key

						#  combination of AFINN and WIEBE is by far best with least outliers
						params[:mixed] = (params[:afinn]+params[:wiebe])/2
						mixed_scores << params[:mixed]
						
						unless story_already_saved?(params)

							save_stories(params)  
							 "#{params[:title]} is new"
					
						else
							story_array << params

							p "#{params[:title]} saved previously"
						end
					end
				end

				todays_stories[key] = story_array.sort{|a,b|a[:mixed]<=>b[:mixed]}.select{|a|a[:mixed]<0}

				mixed_normalized = average(mixed_scores).round(2)

				#save data to AR
				save_scores(key,mixed_normalized)

				# add to today's data array
				todays_data << mixed_normalized
		# }

		p "finishing #{key} RSS: #{v}"
	end

	# join concurrent threads to trigger them
	# threads.each { |aThread|  aThread.join}

	# return today's data


	# p todays_stories.each_pair{|k,v| p k; p v.length}

	return  [todays_data, todays_stories]



end


def formatforD3(obj)

	s = []
	total = obj.values.inject(:+)

	obj.each_pair do |k,v|
	
		h = {}
		h['lang']=k
		h['amount']=(100.0*v/total).round(2)
		s << h
	end

	return s
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

def sort_scores_by_date(data)

	# @allscores, @tmp = [],[]
 #    @previous = data[-1]
 #    # unique_data = data.each{|a| a.score && a.source && a.date.strftime("%h/%d/%m/%Y")}

 #    data.each_with_index do |s,i|
 #      if i==0
 #        @tmp << s
 #      elsif s.date.strftime("%h/%d/%m/%Y")==@previous.date.strftime("%h/%d/%m/%Y")
 #        @tmp << s
 #      else
 #        @allscores << @tmp
 #        @tmp = [s]
 #      end
 #      @previous=s
 #    end

 #    @allscores.sort{|a,b|a[0].date <=>b[0].date}.each{|a| a.each{|b| p b}}
end

