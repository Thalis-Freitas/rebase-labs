require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require_relative 'import_data_csv'

get '/api/exams' do
  ImportDataCsv.new
  conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  exams = conn.exec('SELECT * FROM EXAMS')
  exams.map { |e| e }.to_json
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)
