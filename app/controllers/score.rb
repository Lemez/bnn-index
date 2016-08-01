SerenityPadrino::Serenity.controllers :score do
  
  require 'json'
  require 'active_record'
  require 'pry'

  layout :data
  get :index, :map => '/' do

    @loading=true
    $current_time = Time.now
    $current_day = $current_time.formatted_date
    $time = $current_time.strftime("%X")
    $date = $current_time.strftime('%d/%m/%Y')
    $date_ds_format = Time.now.strftime("%Y-%m-%d")
    $current_time_formatted = $current_time.strftime('%X-%d/%m/%Y')

    # START today's stories ###########
        p "getting todays stories"

        if not already_fetched_RSS_today?
          p "getting RSS"  
          set_up_sentiment_analysers 
          get_todays_rss
        end

        if $offline 
          @day = Date.parse(Story.last.date.formatted_date)
        else
          @day = Date.today
          add_dailyscore_record_for_today_if_none
          
        end

          $grimmest_articles_today = get_todays_saved_story_objects({:date => @day})
          @todays_data = Score.from_day(@day).uniq(:source).order(:score)
          @todays_papers_ordered = @todays_data.collect(&:source).map(&:downcase)
          @todays_scores = @todays_data.collect(&:score)

          p $grimmest_articles_today
          p @todays_data.collect(:id, :source)

        p "DONE todays stories"
    # END # today's stories ###########

    # START awards ############
        p "getting awards"

         #using Float.nan? to remove all quirks with floats
        stories = Story.all
        .select(:title,:source,:date,:mixed)
        .select{|a| !a.mixed.nan?}
        .sort{|a,b| a.mixed <=> b.mixed}

        stories = stories.uniq{|a|a.title.downcase}

        @story_neg, @story_pos = stories[0..9], stories[-10..-1].reverse

        p "DONE awards"
    # END # awards ###########

    # START chart data ###########

        p "getting chart data"
              # D3 CSV js output
              #       [
              #   {"Year": "1997", "Make": "Ford", "Model": "E350", "Length": "2.34"},
              #   {"Year": "2000", "Make": "Mercury", "Model": "Cougar", "Length": "2.38"}
              # ]

        # @all_scores = DailyScore.all.pluck_to_hash(:date,:mail,:telegraph,:times,:guardian,:independent,:express,:average).to_json.html_safe

        attribute_strings = [:date,:mail,:telegraph,:times,:guardian,:independent,:express,:average].map(&:to_s)
        all_scores_array = []
        all_scores = DailyScore.all.order(:date).pluck(:date,:mail,:telegraph,:times,:guardian,:independent,:express,:average).each{|m|m[0]=m[0].to_s[0..9]}
        all_scores.each{|a| all_scores_array << Hash[*attribute_strings.zip(a).flatten] }
        @all_scores_json = all_scores_array.to_json.html_safe
       
        # scores = sort_and_deliver_scores(Score.all)
        # @all_scores = scores.to_json.html_safe

        p "DONE chart data"
    # END # chart data ###########

  
    # START prepare local variables for erb  ##############
    
     @project = [{"lang"=>"JavaScript","amount"=>56.39},{"lang"=>"HTML","amount"=>21.18},{"lang"=>"Ruby","amount"=>14.54},{"lang"=>"CSS","amount"=>6.07}].to_json.html_safe
     @total = 261690
     @grim_today=$grimmest_articles_today.to_json.html_safe

    # END prepare local variables for erb  ##############

    # START render #############
    @loading=false
    render 'index'

  end
end



