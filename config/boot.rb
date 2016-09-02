# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)
require "net/ping"

# configure { set :server, :puma }

SIMILARITY_THRESHOLD = 0.5
DAILY_NUMBER = 10


POS_TYPES = {
'CC' => {:name => 'Conjunction',:desc =>'coordinating'  , :example =>    ['and', 'or']},           
'CD' => {:name => 'Adj',:desc =>'cardinal number' , :example => ['3', 'fifteen']}     ,              
'DET'=> {:name => 'Determiner',:desc =>'determining word' , :example => ['this', 'each', 'some']}     ,                              
'EX' => {:name => 'Pronoun',:desc =>'existential there ', :example =>  ['there']}     ,             
'FW' => {:name =>'Foreign' ,:desc =>'non-English', :example => ['hummus']}     , 						           
'IN' => {:name =>'Preposition' ,:desc =>'general', :example => ['for', 'of', 'although', 'that']}     ,                
'JJ'  => {:name => 'Adj',:desc =>'simple', :example => ['happy', 'bad']}    ,                                
'JJR' => {:name =>'Adj' ,:desc =>'comparative', :example => ['happier', 'worse']}    ,                   
'JJS' => {:name => 'Adj',:desc =>'superlative', :example => ['happiest', 'worst']}    ,                   
'LS'  => {:name => 'Symbol',:desc =>'list item ', :example => ['A', 'A.']}    ,                       
'MD'  => {:name => 'Verb',:desc =>'modal', :example => ["can", "could", "'ll"]}    ,                              
'NN'  => {:name => 'Noun',:desc =>'general', :example => ['aircraft', 'data']}    ,                                     
'NNP'  => {:name => 'Noun',:desc =>'proper', :example => ['London', 'Michael']}   ,                             
'NNPS'  => {:name => 'Noun',:desc =>'proper plural', :example => ['Australians', 'Methodists']}  ,                     
'NNS'  => {:name => 'Noun',:desc =>'plural', :example => ['women', 'books']}   ,                             
'PDT'  => {:name => 'Determiner',:desc =>'prequalifier', :example => ['quite', 'all', 'half']}   ,                 
'POS'  => {:name => 'Possessive',:desc =>'S', :example => ['s']}    ,                              
'PRP'  => {:name => 'Possessive',:desc =>'possessive second', :example => ['mine', 'yours']}   ,          
'PRPS'  => {:name =>'Determiner' ,:desc =>'possessive', :example => ['their', 'your']}  ,                   
'RB'  => {:name => 'Adverb',:desc =>'general', :example => ['often', 'not', 'very', 'here']}    ,                          
'RBR' => {:name => 'Adverb',:desc =>'comparative', :example => ['faster']}    ,                      
'RBS' => {:name => 'Adverb',:desc =>'superlative', :example => ['fastest']}    ,                      
'RP'  => {:name => 'Adverb',:desc =>'particle', :example => ['up', 'off', 'out']}    ,                         
'SYM'  => {:name => 'Symbol',:desc =>'general', :example => ['*']}   ,                          
'TO'   => {:name => 'Preposition',:desc =>'general', :example => ['to']}   ,                     
'UH'   => {:name => 'Interjection',:desc =>'general', :example => ['oh', 'yes', 'mmm']}   ,                    
'VB'   => {:name => 'Verb',:desc =>'infinitive', :example => ['take', 'live']}   ,                         
'VBD'  => {:name => 'Verb',:desc =>'past tense ', :example => ['took', 'lived']}   ,                        
'VBG' => {:name => 'Verb',:desc =>'gerund', :example =>['taking', 'living'] }    ,                             
'VBN' => {:name => 'Verb',:desc =>'past/passive participle ', :example =>['taken', 'lived'] }    ,           
'VBP'  => {:name => 'Verb',:desc =>'base present form ', :example => ['take', 'live']}   ,                 
'VBZ'  => {:name => 'Verb',:desc =>'present third person singular ', :example => ['takes', 'lives']}   ,     
'WDT'  => {:name => 'Determiner',:desc =>'question', :example => ['which', 'whatever']}   ,                     
'WP'   => {:name =>'Pronoun' ,:desc =>'question', :example => ['who', 'whoever']}   ,                        
'WPS'  => {:name => 'Determiner',:desc =>'possessive & question', :example => ['whose']}   ,        
'WRB'   => {:name => 'Adverb',:desc =>'question', :example => ['when', 'how', 'however']}  ,                         
'PP'    => {:name => 'Punctuation',:desc =>'sentence ender', :example => [".", "!", "?"]}  ,              
'PPC'   => {:name => 'Punctuation',:desc =>'comma', :example => [","]}  ,                       
'PPD'   => {:name => 'Punctuation',:desc =>'dollar sign', :example => ["$"]}  ,                 
'PPL'   => {:name => 'Punctuation',:desc =>'quotation mark left ', :example => ["`"]}  ,        
'PPR'   => {:name => 'Punctuation',:desc =>'quotation mark right ', :example => ["'"]}  ,       
'PPS'   => {:name => 'Punctuation',:desc =>'colon, semicolon, elipsis', :example => [":","...","-"]}  ,   
'LRB'   => {:name => 'Punctuation',:desc =>'left bracket', :example => ["(", "{", "["]}  ,                
'RRB'   => {:name => 'Punctuation',:desc =>'right bracket ', :example => [")", "}", "]"]}             
}

RELEVANT_POS = ['Adverb','Adj','Noun','Verb']

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

SMILEYS = {
	'smiley' => "images/emoji/_smiley.png",
	'yellow' => "images/emoji/_yellow.png",
	'orange' => "images/emoji/_orange.png",
	'red' => "images/emoji/_red.png",
	'black' => "images/emoji/_black.jpg"
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

    $reset_date = get_reset_date

    require_relative("#{PADRINO_ROOT}/app/rss.rb")

    @online = Net::Ping::External.new("8.8.8.8").ping?
    p "online: #{@online}, $reset_date: #{$reset_date}, ENV: #{RACK_ENV}"

    if @online
		check_fetch_update_today_if_needed
	end

	$day = (@online ?  Date.today : Date.parse(Story.last.date.formatted_date))
    $grimmest_articles_today = get_todays_saved_story_objects({:date => $day})

    @logomap = {}
    LOGOS.keys.each{|k| @logomap[k.titleize] = LOGOS[k] }
    $logos = @logomap.to_json.html_safe
    $smileys = SMILEYS.to_json.html_safe
end

Padrino.load!
