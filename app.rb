require 'sinatra'
require './import_data_csv'
require './app/jobs/importer_job'
require 'pg'

get '/' do
	send_file './public/index.html'
end

get '/api/exams' do
	content_type 'application/json'
	data = ImportDataCsv.new
  data.create_table
	data.insert_records('./data.csv')
	data.all.to_json
end

post '/import' do
	ImportDataCsv.new.insert_records(params[:csv])
	'Dados registrados com sucesso!'
end

post '/import_enqueue' do
  ImporterJob.perform_async(params[:file])
  'Ok'
end