SerenityPadrino::Serenity.controllers :score do
  
  require 'json'
  require 'active_record'
  require 'pry'


  layout :data
  get :index, :map => '/' do

      @todays_data = Score.from_day($day).uniq(:source).order(:score)
      @todays_papers_ordered = @todays_data.collect(&:source).map(&:downcase)
      @todays_scores = @todays_data.collect(&:score)
      @logos = $logos

    render 'index'
  end

  get :today, :map => '/today.html' do

        

          # START prepare local variables for erb  ##############
          @todays_data = Score.from_day($day).uniq(:source).order(:score)
          @todays_papers_ordered = @todays_data.collect(&:source).map(&:downcase)
          @todays_scores = @todays_data.collect(&:score)
    
          @grim_today=$grimmest_articles_today.to_json.html_safe
          @date =$date.to_json.html_safe
          @time =$time.to_json.html_safe

    # END prepare local variables for erb  ##############
  
    render 'today'
  end

  get :awards, :map => '/awards.html' do

         #using Float.nan? to remove all quirks with floats
        stories_ever = Story.worst_since($reset_date).uniq{|a|a.title.downcase}
        stories_month = Story.worst_since(Date.today-30).uniq{|a|a.title.downcase}
        stories_week = Story.worst_since(Date.today-7).uniq{|a|a.title.downcase}

        @story_neg_ever,@story_neg_month,@story_neg_week  = stories_ever[0..9],stories_month[0..9],stories_week[0..9]
        @story_pos_ever,@story_pos_month,@story_pos_week = stories_ever[-10..-1].reverse,stories_month[-10..-1].reverse,stories_week[-10..-1].reverse

        @trophies = {
          'ever'=>{'trophies'=>"", 'max'=>0},
         'month'=>{'trophies'=>"", 'max'=>0},
         'week'=>{'trophies'=>"", 'max'=>0}
       }
        @trophies_ever = DailyScore.get_trophies_since($reset_date)
        @trophies_month = DailyScore.get_trophies_since(Date.today-30)
        @trophies_week = DailyScore.get_trophies_since(Date.today-7)

        @trophies['ever']['trophies'] = @trophies_ever
        @trophies['ever']['max'] = @trophies_ever.map{|a|a[1]}.max
        @trophies['month']['trophies'] = @trophies_month
        @trophies['month']['max'] = @trophies_month.map{|a|a[1]}.max
        @trophies['week']['trophies'] = @trophies_week
        @trophies['week']['max'] = @trophies_week.map{|a|a[1]}.max
        @trophiesJS = @trophies.to_json.html_safe

        render 'awards'
  end



  get :chart, :map => '/chart.html' do
        
        attribute_strings = [:date,:mail,:telegraph,:guardian,:independent,:express,:average].map(&:to_s)
        @all_scores_array = []
        all_scores = DailyScore.where('created_at > ?', $reset_date).order(:date).pluck(:date,:mail,:telegraph,:guardian,:independent,:express,:average)
        
        all_scores.each do |ds|
          ds[0]=ds[0].to_s[0..9] # string "2016-08-01 00:00:00 UTC" to "2016-08-01"
          @all_scores_array << Hash[*attribute_strings.zip(ds).flatten] 
        end

        @all_scores_json = @all_scores_array.to_json.html_safe
       
        # scores = sort_and_deliver_scores(Score.all)
        # @all_scores = scores.to_json.html_safe

        @logos = $logos

        render 'chart'
  end

    get :info, :map => '/info.html' do

      @project = [{"lang"=>"JavaScript","amount"=>56.39},{"lang"=>"HTML","amount"=>21.18},
      {"lang"=>"Ruby","amount"=>14.54},{"lang"=>"CSS","amount"=>6.07}].to_json.html_safe
      @total = 261690
  
    render 'info'
  end
end



