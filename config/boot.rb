# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

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
LOGOS =  {                 
			'Express'=> "Express-long.png",
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
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
end

Padrino.load!
