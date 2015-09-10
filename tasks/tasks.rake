namespace :score do
	require_relative '../app/rss.rb'

	task :get_and_save_today_to_db => :environment do
		set_up_sentiment_analysers
        @todays_data = get_todays_rss[0] * "," # converts array to CS String
 		save_to_dropbox(@todays_data)
	end

end