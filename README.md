On Puma webserver:

start with 

>> puma
or
>> rackup -s Puma

and access at http://127.0.0.1:9292

With auto-loading:

INSTALLED rerun gem (not on gemfile as only need locally)

>> rerun 'rackup -s Puma' --background
https://github.com/alexch/rerun/issues/88

Pry
binding.pry - start pry
exit - exit single pry loop
disable-pry - cancel all pry 

Generate a model
>> padrino-gen model dailyscore average:float date:datetime express:float independent:float guardian:float telegraph:float mail:float times:float

Destroy a model
>> padrino g model DailyScore -d

To DO:

use pg-dump tool to copy over local pg db to online heroku db, which is currently only having today's data

save cron jobs to AR

For days where DailyScore is absent, take data from production_papers

filter d3 for uniq by day

AR tips:
 # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/' do
  #   'Hello world!'
  # end

  get word analysis scores
  word.get_all_word_scores 
  					or with writing to CV
  word.get_all_word_scores(options = {:write => true}) 

