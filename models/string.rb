require 'lemmatizer'


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

	def is_caps?
		self == self.upcase
	end

	def is_a_dictionary_word?
		$common_list.key?(self)
	end

	def is_not_a_common_acronym?
		!$acronyms.key?(self)
	end

	def is_shouting?(word)
		self.is_caps? && word.is_a_dictionary_word? && word.is_not_a_common_acronym?
	end

	def get_all_word_scores(options = {:write => false})

  		options[:write] ? @write_word_scores = true : @write_word_scores = false

		aggregate_afinn,aggregate_wiebe,aggregate_shouts = 0.0,0.0,0.0
		all_words = self.split(/\W+/)
		lem = Lemmatizer.new
		params = {
			:afinn_average => aggregate_afinn,
			:wiebe_average => aggregate_wiebe,
			:shouts => aggregate_shouts,
			:words => [] 
		}

		@csv_test = CSV.open("#{Padrino.root}/word_scores.csv", "w") do |csv|

			 csv << ["word","lemma","is_shouting?","afinn","wiebe","total"]
			all_words.each do |w|
				
				w = w.strip
				next if w.empty?

				word = lem.lemma(w.downcase)
			 	afinnscore=$afinn[word]
			 	afinnscore.nil? ? afinnscore=0 : afinnscore=(afinnscore/3.0).round(2)
			 	aggregate_afinn += afinnscore

			 	wiebescore=$wiebe[word]
		 		wiebescore.nil? ? wiebescore=0 : wiebescore=wiebescore[:sentiment]
			 	aggregate_wiebe += wiebescore

			 	shouting = w.is_shouting?(word)
			 	aggregate_shouts +=1 if shouting
			 	
			 	word_object = {
			 	:word => w,
			 	:lemma => word,
			 	:shouting => shouting,
			 	:afinn => afinnscore,
			 	:wiebe => wiebescore
			 	}

			 	params[:words] << word_object

			 	penalty = (shouting ? 1 : 0)
			 	aggregate = (aggregate_afinn+aggregate_wiebe-aggregate_shouts).round(2)

			 	if @write_word_scores
			 		csv << [w,word,shouting,afinnscore,wiebescore, aggregate]
				end
			end
		end

		params[:afinn_average] = aggregate_afinn
		params[:wiebe_average] = aggregate_wiebe
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
			 	csv << [word,afinnscore,wiebescore]
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