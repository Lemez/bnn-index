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

def get_keywords_on(d)
	set_up_sentiment_analysers if $afinn.nil?
	title = Story.on_date(d.to_s).map(&:title).join(" ")
	hist = title.process_for_histogram
	hist
end

def get_typical_stories
	set_up_sentiment_analysers
	date1 = Story.first.date.midnight.to_date
	date2 = (Story.last.date.midnight + 1.day).to_date
	@total_bag = []

	date1.upto(date2).each do |d|  
		title = Story.on_date(d.to_s).map(&:title).join(" ")
		hash = title.process_for_histogram

		p "#{d.to_s}: #{hash}" 
		@total_bag << hash

	end

	p "Total:" 
	p @total_bag.flatten.join(" ").process_for_histogram(options={:num=>9})
end