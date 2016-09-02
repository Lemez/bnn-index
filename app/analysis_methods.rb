def lookup(word)
	set_up_sentiment_analysers
	{:afinn=> $afinn[word],:wiebe=> $wiebe[word]}
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

		        storytmp[index] = {'score'=>afinnscore + wiebescore, 'shouting'=> shouting, 'lemma' => word}

	        end

	        results[story.id] = storytmp
	    end
	end

	p results
	results
end

def get_word_score(word,w,pos)

	afinnscore=$afinn[word]
 	if afinnscore.nil?
 		afinnscoreFinal=0
 	else
 		afinnscoreFinal=afinnscore.round(2)
 		p "A match: #{word}: #{afinnscoreFinal}"
 	end
 	
	wordpos = POS_TYPES[pos][:name].downcase
 	wiebescore=$wiebe[word]

 	if wiebescore.nil? 
 		wiebescoreFinal=0
 	else
 		if wiebescore[:pos] == (wordpos || 'anypos' )
 			wiebescoreFinal=wiebescore[:sentiment]
 			p "W match: #{word}: #{wiebescoreFinal} #{wiebescore[:pos]}, #{wordpos}"

 		elsif wiebescore[:pos] == 'verb' && wordpos == 'noun'
 			# specific journalese tagger miscategorisation
 			wiebescoreFinal=wiebescore[:sentiment]/2
 			p "W v/n mismatch: #{word}: #{wiebescoreFinal} #{wiebescore[:pos]}, #{wordpos}"
 		else
 			p "W mismatch: #{word}: #{wiebescore[:pos]}, #{wordpos}"
 			wiebescoreFinal=0
 		end
 	end

 	afinnscoreFinal = 0 if $erratum_list.include?(w)
 	wiebescoreFinal = 0 if $erratum_list.include?(w)

 	[afinnscoreFinal,wiebescoreFinal]
end

def recalculate_story_scores(last_checked)

	Story.where('id > ?',last_checked).where('created_at < ?', Date.today-14).
			order(:id).
			select{|s| s.date.formatted_date == s.created_at.formatted_date}.
			each do |s|
		p s.id

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