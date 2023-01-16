require 'spec_helper'
require 'sinatra'
require './database'
require './import_csv'

describe Database do
	context '#insert_exams_records' do
		it 'deve inserir os registros no banco de dados' do
      db = Database.new
      db.create_exams_table
      db.insert_exams_records('./spec/support/exams.csv')
			all_exams = db.all_exams
			
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
		end
	end
end