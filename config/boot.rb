# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

# configure { set :server, :puma }



SOURCES =  {                 
			'Express'=>"http://feeds.feedburner.com/daily-express-news-showbiz",
			'Guardian'=>"http://www.theguardian.com/uk/rss",
			'Independent'=>'http://independent.co.uk/news/rss',
			'Mail'=>'http://www.dailymail.co.uk/news/index.rss',
			'Telegraph'=>'http://www.telegraph.co.uk/news/rss.xml'
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
