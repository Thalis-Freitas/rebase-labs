require 'sinatra'
require './import_data_csv.rb'

get '/' do
	send_file './public/index.html'
end

get '/api/exams' do
	content_type 'application/json'
	data = ImportDataCsv.new
	data.insert_records('./data.csv')
	data.all.to_json
end
