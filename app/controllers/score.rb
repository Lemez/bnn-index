SerenityPadrino::Serenity.controllers :score do
  
  require 'json'
  require 'active_record'
  require 'pry'


  layout :data
  get :index, :map => '/' do

      @todays_data = Score.from_day($day).uniq(:source).order(:score)
      @todays_papers_ordered = @todays_data.collect(&:source).map(&:downcase)
      @todays_scores = @todays_data.collect(&:score)

    render 'index'
  end

  get :info, :map => '/info.html' do

      @project = [{"lang"=>"JavaScript","amount"=>56.39},{"lang"=>"HTML","amount"=>21.18},
      {"lang"=>"Ruby","amount"=>14.54},{"lang"=>"CSS","amount"=>6.07}].to_json.html_safe
      @total = 261690
  
    render 'info'
  end

  get :awards, :map => '/awards.html' do
       # START awards ############

         #using Float.nan? to remove all quirks with floats
        stories = Story.where('created_at > ?', $reset_date)
        .select(:title,:source,:date,:mixed)
        .reject{|a| a.mixed.nan?}
        .sort{|a,b| a.mixed <=> b.mixed}
        .each{|a| a.source = a.source.titleize}

        stories = stories.uniq{|a|a.title.downcase}

        @story_neg = stories[0..9]
        @story_pos = stories[-10..-1].reverse

        render 'awards'
    # END # awards ###########
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
end



