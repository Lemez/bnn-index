# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)
require "net/ping"

# configure { set :server, :puma }


DAILY_NUMBER = 10
SOURCES =  {                 
			'Express'=>"http://feeds.feedburner.com/daily-express-news-showbiz",
			'Guardian'=>"https://www.theguardian.com/uk/rss",
			'Independent'=>'http://independent.co.uk/news/rss',
			'Mail'=>'http://www.dailymail.co.uk/news/index.rss',
			'Telegraph'=>'http://www.telegraph.co.uk/news/rss.xml'
			# 'Standard'=>"http://www.standard.co.uk/rss"
			# 'Sun' => 'http://www.thesun.co.uk/sol/homepage/'
			# 'Times'=>"http://www.thetimes.co.uk/tto/newsrss/?service=rss"
			}
CURRENT_NAMES = ['guardian','telegraph','mail','independent','express']
EXCLUDE = ['express']

SCRAPERS = {
	'express' => "https://www.bing.com/news/search?q=site%3A+www.express.co.uk%2Fnews&go=Search&qs=bs&form=QBNT",
	'sun' => "https://www.bing.com/news/search?q=site%3awww.thesun.co.uk&ArticleSource=1",
	'times' => "https://www.bing.com/news/search?q=site%3awww.thetimes.co.uk&qft=sortbydate%3d%221%22&form=YFNR",
	'independent' => "https://www.bing.com/news/search?q=site%3awww.independent.co.uk%2Fnews&qft=sortbydate%3d%221%22&form=YFNR"
}
LOGOS =  {'Express'=> "Express-long-better.jpg",
			'Guardian'=>"Guardian-long.jpg",
			'Independent'=>"Independent-long.png",
			'Mail'=>"Mail-long.png",
			'Telegraph'=>"Telegraph-long.jpg",
			"Standard"=>"145x88_ES.png"
			# 'Sun' => 'http://www.thesun.co.uk/sol/homepage/'
			# 'Times'=>"http://www.thetimes.co.uk/tto/newsrss/?service=rss"
			}


##
# ## Enable devel logging
#
Padrino::Logger::Config[:development][:log_level] = :error
# Padrino::Logger::Config[:development] = { :log_level => :fatal}
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
# I18n.enforce_available_locales = false
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
	# @command = 'sass ./public/stylesheets/serenity.scss ./public/stylesheets/serenity.css'
	# system @command
	# p "reloading sass: #{@command}"
	# @watch = "sass --watch public/stylesheets"
	# system @watch
	# p "watching sass: #{@watch}"
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
	
	$current_time = Time.now
    $current_day = $current_time.formatted_date
    $time = $current_time.strftime("%X")
    $date = $current_time.strftime('%d/%m/%Y')
    $date_ds_format = Time.now.strftime("%Y-%m-%d")
    $current_time_formatted = $current_time.strftime('%X-%d/%m/%Y')

    $reset_date = Date.parse("2016-08-01")

    require_relative("#{PADRINO_ROOT}/app/rss.rb")

    @online = Net::Ping::External.new("8.8.8.8").ping?
    p "online: #{@online}"

    if @online
	check_and_fetch_today_if_needed
	add_dailyscore_record_for_today_if_none if all_sources_fetched?
	end

	$day = (@online ?  Date.today : Date.parse(Story.last.date.formatted_date))
    $grimmest_articles_today = get_todays_saved_story_objects({:date => $day})

    @logomap = {}
    LOGOS.keys.each{|k| @logomap[k.titleize] = LOGOS[k] }
    $logos = @logomap.to_json.html_safe
end

Padrino.load!
