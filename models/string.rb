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
		 	score.nil? ? result =0 : result=score/3.0
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
