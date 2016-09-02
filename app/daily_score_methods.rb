#<Score id: 1, date: "2015-09-02 00:00:00", score: -0.6, source: "Mail", created_at: "2015-09-02 04:32:07", updated_at: "2015-09-02 04:32:07", afinn: nil, wiebe: nil, mixed: nil>
# 2.0.0-p353 :002 >

def create_or_update_dailyscore_for(day)
  
  p "Attempting to add DailyScore for #{day}"
  
  scores = Score.on_date(Date.parse(day))
  if scores.exists?
    @dsdata = to_daily_score_format(scores)
    save_record_as_daily_score_object(@dsdata)
  else
    p "No Score data on #{day} found"
  end

end

def to_daily_score_format(data)
    params = {:date => data.first.date, :average => data.map(&:score).get_average.round(2), :topics => get_keywords_on(data.first.date)}
    data.each {|s| params[s.source.downcase.to_sym] = s.score}
    params
end

def save_record_as_daily_score_object(scores_formatted)

  day = scores_formatted[:date]

  @ds = DailyScore.find_or_create_by(date:day) do |ds| 
    ds.update(scores_formatted)
  end

  if @ds.persisted?
      status = (@ds.just_created? ? "New" : "Updated")
      p "DailyScore #{status}, #{@ds.attributes} " 
    else
      p "DailyScore not updated"
    end
end 

def add_dailyscore_record_for_today_if_none
  
  p "Adding DailyScore"
  
  data = to_daily_score_format(Score.from_today)
  save_record_as_daily_score_object(data)

end


def update_or_create_all_daily_scores
  date1 = Story.since_day($reset_date).first.date.midnight.to_date
  date2 = (Story.last.date.midnight + 1.day).to_date

  date1.upto(date2).each do |date| 
    create_or_update_dailyscore_for(date.to_s)
  end
end

def add_topics_to_dailyscores
  dates = DailyScore.since_day($reset_date).map(&:date).map!(&:formatted_date)
  dates.each {|d| create_or_update_dailyscore_for(d)}
end


def get_all_nan_values_from_ds
  failed = []
  DailyScore.all.each do |ds|
    failed << ds if !ds.is_complete?
  end
  failed
end

def log_incomplete_ds
  incomplete = get_all_nan_values_from_ds.flatten
  t = Time.now.to_f * 1000
  incomplete.each do |record|
    record.log_missing_attrs(t) 
  end
end


