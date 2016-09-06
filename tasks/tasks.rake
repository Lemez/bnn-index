namespace :score do
	require_relative '../app/rss.rb'

  Dir.glob('../model/*'){|f| require_relative f}
  
  task :seed_scores => :environment do
    sort_and_deliver_scores(Score.all)
  end

	task :get_and_save_today_to_db => :environment do
		set_up_sentiment_analysers

      $current_time = Time.now
      $current_day = $current_time.formatted_date
      $time = $current_time.strftime("%X")
      $date = $current_time.strftime('%d/%m/%Y')
      $current_time_formatted = $current_time.strftime('%X-%d/%m/%Y')

      check_fetch_update_today_if_needed
	end

  task :check_fetch_and_update_all_hourly => :environment do
    check_fetch_RSS_hourly
    update_scores_and_daily_score
  end


  task :update_stories_in_db => :environment do
    set_up_sentiment_analysers
    last_id_checked = ENV['id'] || 0
    recalculate_story_scores(last_id_checked)
  end


end

