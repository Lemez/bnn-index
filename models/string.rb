require 'lemmatizer'
require "sentimental"
require 'engtagger'

$tgr = EngTagger.new
$lem = Lemmatizer.new

class String

	def to_pos
		$tgr.get_readable(self)
	end

	def sentence_to_pos
		$tgr.get_readable(self).split(" ").map{|s| word,pos = s.split("/"); [word,pos]}
	end

	def return_relevant_pos_tags
		relevantWordTagPairs = {}
		self.sentence_to_pos.each do |pair| 
			word,pos = pair
			type = POS_TYPES[pos][:name]
			 if RELEVANT_POS.include?(type)
			 	relevantWordTagPairs[word.lemmatize]={:pos => pos, :lemma => word.lemmatize, :word => word, :type => type.downcase}
			 end
		end

		relevantWordTagPairs

	end

	def get_sentiment
		$analyzer.sentiment self
	end

	def get_sentiment_score
		$analyzer.score self
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

	def is_caps?
		self == self.upcase
	end

	def is_a_dictionary_word?
		$common_list.key?(self) ||  $common_list.key?(self.singularize) ||
		$afinn.key?(self) || $afinn.key?(self.singularize) ||
		$wiebe.key?(self) || $wiebe.key?(self.singularize)

	end

	def is_not_a_common_acronym?
		!$acronyms.key?(self)
	end

	def is_in_erratum_list?
		!$erratum_list.include?(self)
	end

	def is_long_enough?
		self.length > 2
	end

	def is_shouting?(word)
		self.is_caps? && word.is_a_dictionary_word? && word.is_not_a_common_acronym? && self.is_long_enough?
	end

	def remove_stopwords
		filter = Stopwords::Snowball::Filter.new "en"
		result = filter.filter self.split(/\W+/).each(&:strip).reject{|a| a.empty?}
		result.join(" ")
	end

	def separate_words
		self.split(" ").each(&:strip).reject{|a| a.empty?}
	end

	def is_a_number?
		self.to_i != 0
	end

	def valid_number?
	    true if Float self rescue false
	end

	def lose_possessive
		if self[-2..-1]=="'s" 
			return self [0..-3]
		else
			return self
		end
	end

	def strip_noise

		return self if not self.is_long_enough?

		$s = self.strip
		$sIndex = 0
		$fIndex = -1

		while $s[$sIndex].gsub(/[[:alpha:]]/,"") != "" 
			$sIndex +=1	

			return self if $s[$sIndex].to_i != 0 # for Fixnum
			
		end

		while $s[$fIndex].gsub(/[[:alpha:]]/,"") != ""
			$fIndex -=1	
		end

		result = self[$sIndex..$fIndex]
		p "*#{self}* -> *#{result}*, #{result.to_pos}" unless result == self
		result

	end

	def dehyphenate_word
		self.split("-")
	end

	def lemmatize
		$lem.lemma(self.downcase)
	end

	def clean_and_filter_for_processing
		# all_words = filter.filter self.split(/\W+/).each(&:strip).reject{|a| a.empty?}
		filter = Stopwords::Snowball::Filter.new "en"
		all_words = filter.filter self.separate_words.reject_empty
		return all_words.reject_numbers.clean_word_noise.unhyphenate
	end


	def get_all_word_scores(options = {:write => false})

  		options[:write] ? @write_word_scores = true : @write_word_scores = false
  		

		aggregate_afinn,aggregate_wiebe,aggregate_shouts = 0.0,0.0,0.0

		@pos_tagged = self.return_relevant_pos_tags
		clean_array = self.clean_and_filter_for_processing
		
		
		params = {
			:sentence => self,
			:word_count => clean_array.length,
			:afinn_aggregate => aggregate_afinn,
			:wiebe_aggregate => aggregate_wiebe,
			:shouts => aggregate_shouts,
			:words => {} 
		}

		@csv_test = CSV.open("#{Padrino.root}/word_scores.csv", "w") do |csv|

			 csv << ["word","lemma","is_shouting?","afinn","wiebe","total"]
			clean_array.each do |w|

				lower = w.downcase
				lemma = w.lemmatize
				@pos_tagged.key?(lemma) ? pos = @pos_tagged[lemma][:pos] : pos = lemma.to_pos.split("/")[-1]

			 	afinnscore,wiebescore = get_word_score(lemma,w,pos)

			 	aggregate_afinn += afinnscore
			 	aggregate_wiebe += wiebescore

			 	shouting = w.is_shouting?(lemma)
			 	aggregate_shouts +=1 if shouting
			 	
			 	word_object = {
			 	:lemma => lemma,
			 	:shouting => shouting,
			 	:afinn => afinnscore,
			 	:wiebe => wiebescore,
			 	:pos => pos
			 	}

			 	params[:words][w] = word_object

			 	if @write_word_scores
			 		aggregate = (aggregate_afinn+aggregate_wiebe-aggregate_shouts).round(2)
			 		csv << [w,lemma,shouting,afinnscore,wiebescore, aggregate]
				end
			end
		end

		params[:afinn_aggregate] = aggregate_afinn
		params[:wiebe_aggregate] = aggregate_wiebe
		params[:shouts] = aggregate_shouts
		return params
	end

	def afinn_probability
			aggregate = 0.0
			all_words = self.split(/\W+/)
			all_words.each do |w|
				word = w.strip.downcase
			 	afinnscore=$afinn[word]
			 	afinnscore.nil? ? result =0 : result=afinnscore/3.0
			 	aggregate += result
			end

		aggregate/all_words.length
	end

	def wiebe_probability

		aggregate = 0.0
		all_words = self.split(/\W+/)
		all_words.each do |w|
			word = w.strip.downcase
		 	wiebescore=$wiebe[word]
		 	wiebescore.nil? ? result =0 : result=wiebescore[:sentiment]
		 	aggregate += result
		end

		aggregate/all_words.length
	
	end


	def save_title_as_words(storyid)
		pos=''
		all_words = self.split(/\W+/).each(&:strip).reject{|a| a.empty?}
		lem = Lemmatizer.new

		all_words.each do |w|
			
			word = lem.lemma(w.downcase)

			next if Word.where(lemma:word).exists? 

		 	afinnscore,wiebescore = get_word_score(word,w,pos)
		 	afinnscore+wiebescore==0 ? score=0 : score=(afinnscore+wiebescore)/2

		 	next if score==0


		 	params = {
				:lemma => word,
				:storyid => storyid,
				:score => score,
				:afinn => !!$afinn[word],
				:wiebe => !!$wiebe[word]
			}

			Word.find_or_create_by(lemma:word) do |wordobj|
				wordobj.update(params)
			end

		end

	end
end
