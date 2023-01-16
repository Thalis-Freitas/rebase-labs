require 'spec_helper'
require './import_csv'
require './app'

describe 'App' do
	def app
		Sinatra::Application
	end

  it 'get /' do
    Database.new.insert_exams_records('./spec/support/exams.csv')

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

	it 'get /api/exams' do
    Database.new.insert_exams_records('./spec/support/exams.csv')
    
    get '/api/exams'

    expect(last_response.status).to eq 200
		expect(last_response.content_type).to eq 'application/json'
  end

  it 'get api/exams/:token' do
    Database.new.insert_exams_records('./spec/support/exams.csv')

    get 'api/exams/IN33R0'

    expect(last_response.status).to eq 200
    expect(last_response.content_type).to eq 'application/json'
    expect(last_response.body).to include '076.278.738-43'
    expect(last_response.body).to include 'Víctor Limeira'
    expect(last_response.body).to include '2021-07-21'
    expect(last_response.body).to include 'eletrólitos'
    expect(last_response.body).to include '2-68'
    expect(last_response.body).not_to include 'Emilly Batista Neto'
    expect(last_response.body).not_to include 'hemácias'
    expect(last_response.body).not_to include '45-52'
  end

  it 'post /import' do
    conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  
    post '/import', csv: './spec/support/exams.csv'
		
    last_exam = conn.exec('SELECT * FROM EXAMS WHERE ID = (SELECT MAX(ID) FROM EXAMS)').to_a.pop
    expect(last_response.status).to eq 200
    expect(last_response.body).to eq 'Dados registrados com sucesso!'
    expect(last_exam['email']).not_to eq 'adalberto_grady@feil.org'
		expect(last_exam['taxpayer_registry']).not_to eq '071.488.453-78'
    expect(last_exam['address']).to eq '968 Viela Maria Vitória'
    expect(last_exam['taxpayer_registry']).to eq '076.278.738-43'
  end

  it 'post /import_enqueue' do
    post '/import_enqueue', csv: './spec/support/exams.csv'

    expect(last_response.status).to eq 200
    expect(last_response.body).to eq 'Ok'
  end
end