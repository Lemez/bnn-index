namespace :score do
	require_relative '../app/rss.rb'
  require_relative '../private/secret.rb'
  Dir.glob('../model/*'){|f| require_relative f}
  
  task :seed_scores => :environment do
    sort_and_deliver_scores(Score.all)
  end

	task :get_and_save_today_to_db => :environment do
		set_up_sentiment_analysers

        @current_time = Time.now
        @time = @current_time.strftime("%X")
        @date = @current_time.strftime('%d/%m/%Y')
        @current_time_formatted = @current_time.strftime('%X-%d/%m/%Y')

    todays_data_for_dropbox = get_todays_rss[0] * "," # converts array to CS String
 		add_dailyscore_record_for_today(Time.now.strftime("%Y-%m-%d"))
    save_to_dropbox(todays_data_for_dropbox)

  

 		# @todays_data = Score.where(date:@current_time).order(:score)
   #      @todays_papers_ordered = @todays_data.collect(&:source)
   #      @todays_scores = @todays_data.collect(&:score)
	end

  def ar_to_array_of_objects(scoreRecords)

  finalscores=[]
  all_dates = scoreRecords.map{|d| d.formatted_date}.uniq 
  all_sources = scoreRecords.map{|d| d.source}.uniq 
  @key_fields = scoreRecords.pluck(:source,:score, :date)

    all_dates.each do |formattedDate|

      params = {}
      params[:date]=formattedDate
          
      data = @key_fields.select{|a| a[-1].formatted_date==formattedDate}
      so_far = 0.0

      all_sources.each do |paper|
        @dailyscores = data.select{|b| b[0]==paper}
        today = @dailyscores.map{|c| c[1]}.inject(:+)

        today = 1 if today.nil? or today.nan?
        @dailyscores = [1] if @dailyscores.nil? or @dailyscores.empty?

        todaysScoresByPaper = (today/@dailyscores.size).round(1)

        thePaper = paper.downcase.to_sym
        params[thePaper.to_sym] = todaysScoresByPaper

        so_far += todaysScoresByPaper
      end

      params[:average] = (so_far / SOURCES.keys.size).round(1)

      finalscores << params

      save_record_as_daily_score_object(params)
      
    end

    finalscores

end

def sort_and_deliver_scores(data)
    ar_to_array_of_objects(data.sort_by_date)
end

def save_record_as_daily_score_object(data)

  @ds = DailyScore.find_or_create_by(date: "#{data[:date]}") do |score|
    score.update_attributes(data)
  end
 

end 

  #<Score id: 1, date: "2015-09-02 00:00:00", score: -0.6, source: "Mail", created_at: "2015-09-02 04:32:07", updated_at: "2015-09-02 04:32:07", afinn: nil, wiebe: nil, mixed: nil>
# 2.0.0-p353 :002 >

def add_dailyscore_record_for_today(currentDate)

  currentDate ||= Time.now.strftime("%Y-%m-%d")
  scores = Score.where(date: currentDate)

  ds = DailyScore.where(date: Date.parse(currentDate)).first_or_create!
  o = {}

  scores.each do |sc| 
    paper = sc.source.downcase
    o[paper] = sc.score
  end

  ds.update!(o)

  p "Saved DailyScore: #{ds}" if ds.persisted?

end

end

