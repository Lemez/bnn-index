require 'lemmatizer'
require "sentimental"
require 'similarity'


class String
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

	def is_shouting?(word)
		self.is_caps? && word.is_a_dictionary_word? && word.is_not_a_common_acronym?
	end

	def get_all_word_scores(options = {:write => false})

  		options[:write] ? @write_word_scores = true : @write_word_scores = false

		aggregate_afinn,aggregate_wiebe,aggregate_shouts = 0.0,0.0,0.0
		all_words = self.split(/\W+/).each(&:strip).reject{|a| a.empty?}
		
		lem = Lemmatizer.new
		params = {
			:sentence => self,
			:word_count => self.split(" ").length,
			:afinn_aggregate => aggregate_afinn,
			:wiebe_aggregate => aggregate_wiebe,
			:shouts => aggregate_shouts,
			:words => {} 
		}

		@csv_test = CSV.open("#{Padrino.root}/word_scores.csv", "w") do |csv|

			 csv << ["word","lemma","is_shouting?","afinn","wiebe","total"]
			all_words.each do |w|

				word = lem.lemma(w.downcase)

			 	afinnscore=$afinn[word]
			 	afinnscore.nil? ? afinnscore=0 : afinnscore=afinnscore.round(2)
			 	afinnscore = 0 if $erratum_list.include?(w)
			 	aggregate_afinn += afinnscore

			 	wiebescore=$wiebe[word]
		 		wiebescore.nil? ? wiebescore=0 : wiebescore=wiebescore[:sentiment]
			 	wiebescore = 0 if $erratum_list.include?(w)
			 	aggregate_wiebe += wiebescore

			 	shouting = w.is_shouting?(word)
			 	aggregate_shouts +=1 if shouting
			 	
			 	word_object = {
			 	:lemma => word,
			 	:shouting => shouting,
			 	:afinn => afinnscore,
			 	:wiebe => wiebescore
			 	}

			 	params[:words][w] = word_object

			 	if @write_word_scores
			 		aggregate = (aggregate_afinn+aggregate_wiebe-aggregate_shouts).round(2)
			 		csv << [w,word,shouting,afinnscore,wiebescore, aggregate]
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
end
