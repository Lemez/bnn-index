def save_record_as_daily_score_object(data)

  @ds = DailyScore.find_or_create_by(date: "#{data[:date]}") do |score|
    score.update_attributes(data)
  end

  p "Saved #{@ds.inspect}" if @ds.persisted?
end 

#<Score id: 1, date: "2015-09-02 00:00:00", score: -0.6, source: "Mail", created_at: "2015-09-02 04:32:07", updated_at: "2015-09-02 04:32:07", afinn: nil, wiebe: nil, mixed: nil>
# 2.0.0-p353 :002 >

def add_dailyscore_record_for_today_if_none
  
  return if DailyScore.from_today.exists?
  p "Adding DailyScore"
  
  data = to_daily_score_format(Score.from_today)
  save_record_as_daily_score_object(data)

end

  def to_daily_score_format(data)
    params = {:date => Date.today, :average => get_average(data.map(&:score))}
    data.each {|s| params[s.source.downcase] = s.score}
    params
  end

