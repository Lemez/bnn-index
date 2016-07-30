def save_record_as_daily_score_object(data)

  @ds = DailyScore.find_or_create_by(date: "#{data[:date]}") do |score|
    score.update_attributes(data)
  end
end 

#<Score id: 1, date: "2015-09-02 00:00:00", score: -0.6, source: "Mail", created_at: "2015-09-02 04:32:07", updated_at: "2015-09-02 04:32:07", afinn: nil, wiebe: nil, mixed: nil>
# 2.0.0-p353 :002 >

def add_dailyscore_record_for_today_if_none

  return if DailyScore.from_today.exists?

  p "Adding DailyScore"
  
  currentDate ||= Time.now.strftime("%Y-%m-%d")
  scores = Score.from_today

  ds = DailyScore.new(date: Date.parse(currentDate))
  o = {}

  scores.each do |sc| 
    paper = sc.source.downcase
    o[paper] = sc.score
  end

  ds.update!(o)

  p "Saved DailyScore: #{ds.inspect}" if ds.persisted?

end
