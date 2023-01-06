require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'import_data_csv'
set :public_folder, 'assets'

get '/' do
  send_file './assets/index.html'
end

get '/api/exams' do
  ImportDataCsv.new.all_in_json
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
