def save_scores(paper,day)

	mixed_score = Story.on_date(day).where(source:paper).map(&:mixed).get_average.round(2)

	if mixed_score.nan? || mixed_score.nil?
		p "Score on #{day} not valid"
		return
	else
		@sc = Score.on_date(day).where(source: paper).first_or_create! do |sc| #ensures only one per paper per day
			sc.date = Date.parse(day)
			sc.score = mixed_score
			sc.save!
		end
		p "Saved Score #{@sc.id}, #{@sc.source}, #{@sc.date}" if @sc.persisted?
	end
end

def check_and_update_scores(day)
 		scores_to_be_fetched = any_scores_not_fetched_today? (day)
	  if scores_to_be_fetched.any?
	      p "saving Scores" 
	      scores_to_be_fetched.each {|params|save_scores(params[:name],day)}
	 end
end

def any_scores_not_fetched_today? (day)

	@not_yet_fetched = []
	CURRENT_NAMES.each do |key|
		 if not Score.where(source:key).on_date(day).exists?
			@not_yet_fetched << params = {:name=> key}
			p "Score on #{day} doesnt exist"
		else
			p "Score on #{day} exists"
		end
	end

	@not_yet_fetched
end


def update_or_create_all_scores
	date1 = Story.first.date.midnight.to_date
	date2 = (Story.last.date.midnight + 1.day).to_date

	date1.upto(date2).each do |date|  
		check_and_update_scores(date.to_s)
	end
end