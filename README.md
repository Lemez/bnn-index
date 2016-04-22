Require anything new inside serenity2.js then Browserify JS changes /
	sudo browserify public/js/serenity2.js -o public/js/bundle.js

start with 
padrino start

On Puma webserver:

start with 

>> rackup -s Puma

and access at http://127.0.0.1:9292

To DO:

use pg-dump tool to copy over local pg db to online heroku db, which is currently only having today's data


