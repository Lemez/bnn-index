def story_not_yet_saved? (params)
	Story.where(:title=>params[:title]).empty?
end

def enough_stories_for_source_already_saved_today?(params)
	Story.from_today.where(source:params[:source]).count == DAILY_NUMBER
end


def save_stories(storyparams)
	st = Story.create(storyparams)
	st.save!
	p "SAVING: #{storyparams[:title]} is new" if st.persisted?
end

def update_story(params)
	s = Story.find(params[:id])
	p "#{s.id}, #{s.date}, #{s.source}, #{s.title}" 

	old = s.mixed
	s.update(params)

	p "Old: #{old} New: #{params[:mixed]}, #{s.title}" if s.persisted?
end

def get_todays_saved_story_objects(options = {:date => date})

	grimmest = {}

	CURRENT_NAMES.each do |source|
		$passed = []
		stories = Story.all
		.from_day(options[:date])
		.uniq(:title)
		.where(:source=>source)
		.order(:mixed)
		.select{|a| a.is_uniqish_by_tfidf(source,options[:date].to_s)}
		# .select{|a| a.is_uniqish(source)}

		grimmest[source] = stories[0..4]

	end

	grimmest
end

