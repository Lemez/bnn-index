Require anything new inside serenity2.js then Browserify JS changes /
	sudo browserify public/js/serenity2.js -o public/js/bundle.js

(old)
start with 
>> padrino start


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

get chart data from AR

filter d3 for uniq by day

