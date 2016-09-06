SerenityPadrino::Serenity.controllers :score do
  
  require 'json'
  require 'active_record'
  require 'pry'


  layout :data
  get :index, :map => '/' do

      @todays_paper_winner =  Score.on_date($day).order(:score).collect(&:source).map(&:titleize).first
      @winner_average_today = Score.on_date($day).order(:score).first.score
      @logo = LOGOS[@todays_paper_winner]

    render 'index'
  end

  get :today, :map => '/today.html' do

          # START prepare local variables for erb  ##############
          set_up_sentiment_analysers

          @todays_data = Score.on_date($day).uniq(:source).order(:score)
          @todays_papers_ordered = @todays_data.collect(&:source).map(&:downcase)
          @todays_scores = @todays_data.collect(&:score)
    
          @grim_today=$grimmest_articles_today.to_json.html_safe

          @g_today = []
          $grimmest_articles_today.each_pair do |k,v|
            v.each do |story|
                  @g_today << {'id'=>story.id,
                   'title'=>story.title}
                 end
          end

          #@words_today = {
         #    31712=>[[1, -6.0], [2, -4.0]],
         #   31713=>[[0, -1.0]]
         # }  
          @words_today = get_scoring_words_from_grimmest
          @words_today_js = @words_today.to_json.html_safe
          @date =$date.to_json.html_safe
          @time =$time.to_json.html_safe

    # END prepare local variables for erb  ##############
  
    render 'today'
  end

  get :headlines, :map => '/headlines.html' do

      @starting_date = get_starting_date
         #using Float.nan? to remove all quirks with floats
        stories_ever = Story.worst_since(@starting_date).uniq{|a|a.title.downcase}
        stories_month = Story.worst_since(Date.today-30).uniq{|a|a.title.downcase}
        stories_week = Story.worst_since(Date.today-7).uniq{|a|a.title.downcase}
        stories_today = Story.worst_since($day).uniq{|a|a.title.downcase}

        @story_neg_ever,@story_neg_month,@story_neg_week, @story_neg_today  = stories_ever[0..9],stories_month[0..9],stories_week[0..9], stories_today[0..9]
        @story_pos_ever,@story_pos_month,@story_pos_week = stories_ever[-10..-1].reverse,stories_month[-10..-1].reverse,stories_week[-10..-1].reverse

        @trophies = {
          'ever'=>{'trophies'=>"", 'max'=>0},
         'month'=>{'trophies'=>"", 'max'=>0},
         'week'=>{'trophies'=>"", 'max'=>0}
       }
        @trophies_ever = DailyScore.get_trophies_since(@starting_date)
        @trophies_month = DailyScore.get_trophies_since(Date.today-30)
        @trophies_week = DailyScore.get_trophies_since(Date.today-7)

        @trophies['ever']['trophies'] = @trophies_ever
        @trophies['ever']['max'] = @trophies_ever.map{|a|a[1]}.max
        @trophies['month']['trophies'] = @trophies_month
        @trophies['month']['max'] = @trophies_month.map{|a|a[1]}.max
        @trophies['week']['trophies'] = @trophies_week
        @trophies['week']['max'] = @trophies_week.map{|a|a[1]}.max
        @trophiesJS = @trophies.to_json.html_safe
       
        render 'headlines'
  end





  get :chart, :map => '/chart.html' do
        @reset = get_reset_date
        p "chart reset_date = #{@reset}"
        attribute_strings = [:date,:topics,:created_at,:ft,:mirror,:mail,:telegraph,:guardian,:independent,:express,:average].map(&:to_s)
        # story_strings = %w(mail_story telegraph_story independent_story express_story guardian_story)
        @all_scores_array = []
        all_scores = DailyScore.since_day(@reset).order(:date).pluck(:date,:topics,:created_at,:ft,:mirror,:mail,:telegraph,:guardian,:independent,:express,:average)
        
        all_scores.each do |ds|
          ds[0]=ds[0].to_s[0..9] # string "2016-08-01 00:00:00 UTC" to "2016-08-01"
          ds[1]=ds[1].to_json
          # @stories = []
          # @all_stories = []
          # date = ds[0]

          # if Story.on_date(date).exists?
          #   @all_stories =  Story.on_date(date).order(:mixed)
          
          #   story_strings.each do |ss|
          #     paper = ss.split("_")[0]

          #     paperstories = @all_stories.where(:source => paper)
          #     paperstoriestitle = @all_stories.where(:source => paper.titleize)

          #         if !paperstories.empty?
          #           @stories << paperstories.first.title
          #         elsif !paperstoriestitle.empty?
          #           @stories << paperstoriestitle.first.title
          #         else
          #          @stories << "No stories available from #{paper.titleize} today"
          #         end
          #   end

          # else
          #     @stories << "No stories available"
          # end

           original_hash = Hash[*attribute_strings.zip(ds).flatten]
           
          # story_hash = Hash[*story_strings.zip(@stories).flatten]
          # merged_hash = original_hash.merge(story_hash)
          # @all_scores_array << merged_hash

          @all_scores_array << original_hash

          p "Hash with ds.created_at: #{ds[2]}, date: #{original_hash['date']}"
        end

        @all_scores_json = @all_scores_array.to_json.html_safe
        @logos = $logos
        @smileys = $smileys

        render 'chart'
  end

    get :global, :map => '/global.html' do

      @all_global_averages = DailyScore.get_scores_since($reset_date)
      @all_global_percentages = @all_global_averages.to_percentages.to_ordered_hash
      @average_global_percentage = @all_global_percentages['average']
      @all_global_percentages.delete('average')
      @oldpercentclass = ''

     render 'global'
  end

  get :info, :map => '/info.html' do

      @project = [{"lang"=>"JavaScript","amount"=>56.39},{"lang"=>"HTML","amount"=>21.18},
      {"lang"=>"Ruby","amount"=>14.54},{"lang"=>"CSS","amount"=>6.07}].to_json.html_safe
      @total = 261690
  
    render 'info'
  end
end



