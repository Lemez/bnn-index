# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
PADRINO_ROOT = File.dirname(__FILE__) + '/..'
set :output, {:error => PADRINO_ROOT+ "log/cron_error_log.log", :standard =>  PADRINO_ROOT+ "log/cron_log.log"}
set :environment, "development"
job_type :padrino_rake, 'cd :path && padrino rake :task -e :environment'


# every 1.day, :at => '4:30 am' do
every :hour do
	p "\n\n #{Time.now} : score:check_fetch_and_update_all_hourly \n\n"
	padrino_rake "score:check_fetch_and_update_all_hourly"
end


# every '0 0,6,12,18 * * *' do # every day, 3 times a day, do
# every '0 6 * * *' do
#   p "\n\n #{Time.now} : score:get_and_save_today_to_db \n\n"
# padrino_rake "score:get_and_save_today_to_db"
# end

# update with `whenever -w`
# check with `crontab -l`


