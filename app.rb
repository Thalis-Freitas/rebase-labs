require 'sinatra'
require './import_csv'
require './app/jobs/importer_job'
require 'pg'

get '/' do
	send_file './public/index.html'
end

get '/api/exams' do
	content_type 'application/json'
	data = Database.new
	data.all_exams.to_json
end

get '/api/exams/:token' do
  content_type 'application/json'
	exams = Database.new.find_exams_by_token(params[:token])
  exams.to_json
end  

post '/import' do
	Database.new.insert_exams_records(params[:csv])
	'Dados registrados com sucesso!'
end

post '/import_enqueue' do
  ImporterJob.perform_async(params[:file])
  'Ok'
end