require 'spec_helper'
require './import_data_csv.rb'
require './app.rb'

describe 'App' do
	def app
		Sinatra::Application
	end

	it 'get /api/exams' do
    conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
    ImportDataCsv.new.insert_records('./spec/support/exams.csv')
    
    get '/api/exams'

    expect(last_response.status).to eq 200
		expect(last_response.content_type).to eq 'application/json'
  end

	it 'get /' do
		conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
    ImportDataCsv.new.insert_records('./spec/support/exams.csv')

		get '/'

    expect(last_response.status).to eq 200
    expect(last_response.body).to include 'Token'
    expect(last_response.body).to include 'Nome'
    expect(last_response.body).to include 'Cpf'
    expect(last_response.body).to include 'Data do Exame'
    expect(last_response.body).to include 'Cidade/Estado'
    expect(last_response.body).to include 'Tipo'
    expect(last_response.body).to include 'Limites'
	end

  it 'post /import' do
    post '/import', csv: './spec/support/exams.csv'
    expect(last_response.status).to eq 200
  end
end