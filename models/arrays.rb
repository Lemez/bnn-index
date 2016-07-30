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