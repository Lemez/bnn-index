def save_record_as_daily_score_object(data)

  ds = DailyScore.find_or_create_by(date: "#{data[:date]}")
  ds.update_attributes(data)
  ds.save!

  p "Saved #{ds.inspect}" if ds.persisted?
end 

#<Score id: 1, date: "2015-09-02 00:00:00", score: -0.6, source: "Mail", created_at: "2015-09-02 04:32:07", updated_at: "2015-09-02 04:32:07", afinn: nil, wiebe: nil, mixed: nil>
# 2.0.0-p353 :002 >

def add_dailyscore_record_for_today_if_none
  
  p "Adding DailyScore"
  
  data = to_daily_score_format(Score.from_today)
  save_record_as_daily_score_object(data)

end

def add_dailyscore_record_for_day_if_none(day)
  
  p "Adding DailyScore for #{day}"
  
  data = to_daily_score_format(Score.on_date(day))
  save_record_as_daily_score_object(data)

end

def all_sources_fetched?
  scores = []
  Score.from_today.each{|s| scores << s.score}
  return scores.all?
end

  def to_daily_score_format(data)
    params = {:date => data.date, :average => data.map(&:score).get_average}
    data.each {|s| params[s.source.downcase] = s.score}
    params
  end

