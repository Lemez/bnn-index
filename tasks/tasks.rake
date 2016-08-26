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

      check_and_fetch_today_if_needed

 		  add_dailyscore_record_for_today_if_none
	end

  task :update_stories_in_db => :environment do
    set_up_sentiment_analysers
    last_id_checked = ENV['id']
    recalculate_story_scores(last_id_checked)
  end


end

