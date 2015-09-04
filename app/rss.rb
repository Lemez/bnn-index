require 'httparty' 
require 'rss'
require 'dropbox_sdk'
require_relative "../private/secret.rb"
require 'csv'
require 'sentimentalizer'
require 'date'

def set_up_sentiment_analysers
	# Sentimentalizer.setup
	afinn_to_hash
	wiebe_to_hash
end



class Hash
	def format_for_dropbox
		return [self['date'],
				self['Mail'],
				self['Times'],
				self['Express'],
				self['Telegraph'],
				self['Guardian'],
				self['Independent']]
	end
end

class String
	def get_sentiments
		return Sentimentalizer.analyze(self)
	end

	def sentimentalizer_probability
		output = self.get_sentiments
		sentiment = output.sentiment
		probability = output.overall_probability
		case sentiment
		when ":("
			probability=-probability
		end

		return probability
	end

	def afinn_probability
		aggregate = 0.0
		all_words = self.split(/\W+/)
		all_words.each do |w|
			word = w.strip.downcase
		 	score=$afinn[word]
		 	score.nil? ? result =0 : result=score/5.0
		 	aggregate += result
		end

		aggregate/all_words.length
	end

	def wiebe_probability

		aggregate = 0.0
		all_words = self.split(/\W+/)
		all_words.each do |w|
			word = w.strip.downcase
		 	score=$wiebe[word]
		 	score.nil? ? result =0 : result=score[:sentiment]
		 	aggregate += result
		end

		aggregate/all_words.length
	
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

	Score.where(date:Date.today, source:paper).first_or_create do |sc|
		sc.score = score
	end

	#ensures only one per paper per day
end

def save_stories(paper,score,headline)
	story = Story.where(title: headline, date: Time.now, score:score, source:paper).first_or_create
	p story
end




def get_todays_rss

	@todays_data = [Time.now.strftime('%X-%d/%m/%Y')]

	SOURCES.each_pair do |k,v|
		rss = open(v).read
		feed = RSS::Parser.parse(rss,false)

		afinn_scores,wiebe_scores,mixed_scores = [],[],[]

		feed.items.each.with_index do |item,i| 
			if i<10
				headline = item.title.strip
				afinn_story = headline.afinn_probability.round(2)*100
				wiebe_story = headline.wiebe_probability.round(2)*100

				#  combination of AFINN and WIEBE is by far best with least outliers
				mixed_story = (afinn_story+wiebe_story)/2
				mixed_scores << mixed_story

				save_stories(k,mixed_story,headline)

			end
		end
		mixed_normalized = average(mixed_scores).round(2)

		#save data to AR
		save_scores(k,mixed_normalized)

		# add to today's data array
		@todays_data << mixed_normalized
		
	end

	# return today's data
	@todays_data
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


def classify

end