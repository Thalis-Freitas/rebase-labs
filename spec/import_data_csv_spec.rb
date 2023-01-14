require 'spec_helper'
require 'sinatra'
require './import_data_csv'

describe ImportDataCsv do
	context '#insert_records' do
		it 'deve inserir os registros no banco de dados' do
			conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
			import_data = ImportDataCsv.new
      import_data.create_table
      import_data.insert_records('./spec/support/exams.csv')
			all_exams = conn.exec('SELECT * FROM EXAMS').to_a
			
      expect(all_exams[0]['address']).to eq '165 Rua Rafaela'
			expect(all_exams[0]['birth_date']).to eq '2001-03-11'
			expect(all_exams[0]['city']).to eq 'Ituverava'
			expect(all_exams[0]['email']).to eq 'gerald.crona@ebert-quigley.com'
			expect(all_exams[0]['exam_date']).to eq '2021-08-05'
			expect(all_exams[0]['limits']).to eq '45-52'
			expect(all_exams[0]['medical_crm']).to eq 'B000BJ20J4'
			expect(all_exams[0]['medical_crm_state']).to eq 'PI'
			expect(all_exams[1]['medical_email']).to eq 'denna@wisozk.biz'
			expect(all_exams[1]['medical_name']).to eq 'Maria Luiza Pires'
			expect(all_exams[1]['name']).to eq 'Víctor Limeira'
			expect(all_exams[1]['result']).to eq '98'
			expect(all_exams[1]['state']).to eq 'Mato Grosso'
			expect(all_exams[1]['taxpayer_registry']).to eq '076.278.738-43'
			expect(all_exams[1]['token']).to eq 'IN33R0'
			expect(all_exams[1]['type_of_exam']).to eq 'eletrólitos'
		end
	end
end