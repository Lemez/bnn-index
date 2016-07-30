require 'csv'
require 'open-uri'

def fill_in_missing_dates_from_csv db_datelist

	path_to_file = 'https://dl.dropboxusercontent.com/u/2448084/papers_production.csv'
	IO.copy_stream(open(path_to_file), 'test.csv')

	csv_array = CSV.read('test.csv', {:headers => true})
  	
  	csvdates = csv_array.map{|row| Date.strptime(row[0], '%X-%d/%m/%Y').to_s}.uniq	

  	fulldatelist = db_datelist + (db_datelist-csvdates)
  	fulldatelist.sort!{|a,b| a<=>b}

end