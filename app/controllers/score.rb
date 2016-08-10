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

    # START info
      @project = [{"lang"=>"JavaScript","amount"=>56.39},{"lang"=>"HTML","amount"=>21.18},
      {"lang"=>"Ruby","amount"=>14.54},{"lang"=>"CSS","amount"=>6.07}].to_json.html_safe
      @total = 261690
    # END info

    # START today's stories ###########

        check_and_fetch_today_if_needed

        if not $online 
          @day = Date.parse(Story.last.date.formatted_date)
        else
          @day = Date.today
          add_dailyscore_record_for_today_if_none if all_sources_fetched?
        end

          $grimmest_articles_today = get_todays_saved_story_objects({:date => @day})
          @todays_data = Score.from_day(@day).uniq(:source).order(:score)
          @todays_papers_ordered = @todays_data.collect(&:source).map(&:downcase)
          @todays_scores = @todays_data.collect(&:score)


          p "DONE todays stories"
    # END # today's stories ###########

    # START chart data ###########


        $reset_date = Date.parse("2016-08-01")
        
        attribute_strings = [:date,:mail,:telegraph,:guardian,:independent,:express,:average].map(&:to_s)
        @all_scores_array = []
        all_scores = DailyScore.where('created_at > ?', $reset_date).order(:date).pluck(:date,:mail,:telegraph,:guardian,:independent,:express,:average)
        
        all_scores.each do |ds|
          ds[0]=ds[0].to_s[0..9] # string "2016-08-01 00:00:00 UTC" to "2016-08-01"
          @all_scores_array << Hash[*attribute_strings.zip(ds).flatten] 
        end

        @all_scores_json = @all_scores_array.to_json.html_safe

        @logomap = {}
        LOGOS.keys.each{|k| @logomap[k.titleize] = LOGOS[k] }
        @logos = @logomap.to_json.html_safe
       
        # scores = sort_and_deliver_scores(Score.all)
        # @all_scores = scores.to_json.html_safe

        p "DONE chart data"
    # END # chart data ###########

    # START awards ############
        p "getting awards"

         #using Float.nan? to remove all quirks with floats
        stories = Story.where('created_at > ?', $reset_date)
        .select(:title,:source,:date,:mixed)
        .reject{|a| a.mixed.nan?}
        .sort{|a,b| a.mixed <=> b.mixed}
        .each{|a| a.source = a.source.titleize}

        stories = stories.uniq{|a|a.title.downcase}

        @story_neg = stories[0..9]
        @story_pos = stories[-10..-1].reverse

        p "DONE awards"
    # END # awards ###########

  
    # START prepare local variables for erb  ##############
    
     @grim_today=$grimmest_articles_today.to_json.html_safe
     @date =$date.to_json.html_safe
     @time =$time.to_json.html_safe

    # END prepare local variables for erb  ##############

    # START render #############
    @loading=false
    render 'index'

  end
end



