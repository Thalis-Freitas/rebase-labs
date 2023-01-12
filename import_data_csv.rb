require 'csv'
require 'pg'

class ImportDataCsv
  def initialize
    @conn = PG.connect(host: 'postgres', dbname: 'postgres', user: 'postgres')
  end

  def create_table
    @conn.exec("CREATE TABLE IF NOT EXISTS EXAMS (
                  ID SERIAL PRIMARY KEY,
                  TAXPAYER_REGISTRY VARCHAR(14) NOT NULL,
                  NAME VARCHAR NOT NULL,
                  EMAIL VARCHAR NOT NULL,
                  BIRTH_DATE DATE NOT NULL,
                  ADDRESS VARCHAR NOT NULL,
                  CITY VARCHAR NOT NULL,
                  STATE VARCHAR NOT NULL,
                  MEDICAL_CRM VARCHAR NOT NULL,
                  MEDICAL_CRM_STATE VARCHAR NOT NULL,
                  MEDICAL_NAME VARCHAR NOT NULL,
                  MEDICAL_EMAIL VARCHAR NOT NULL,
                  TOKEN VARCHAR NOT NULL,
                  EXAM_DATE DATE NOT NULL,
                  TYPE_OF_EXAM VARCHAR NOT NULL,
                  LIMITS VARCHAR NOT NULL,
                  RESULT INTEGER NOT NULL)"
               )
  end

  def csv_data(csv)
    rows = CSV.read(csv, col_sep: ';')
    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end

  def insert_records(csv)
    csv_data(csv).each do |r|
      @conn.exec("INSERT INTO EXAMS (TAXPAYER_REGISTRY, NAME, EMAIL, BIRTH_DATE, ADDRESS, CITY, STATE,
                                     MEDICAL_CRM, MEDICAL_CRM_STATE, MEDICAL_NAME, MEDICAL_EMAIL,
                                     TOKEN, EXAM_DATE, TYPE_OF_EXAM, LIMITS, RESULT)
                  VALUES ('#{r['cpf']}', '#{r['nome paciente']}', '#{r['email paciente']}',
                          '#{r['data nascimento paciente']}', '#{r['endereço/rua paciente']}',
                          '#{@conn.escape_string(r['cidade paciente'])}', '#{r['estado paciente']}',
                          '#{r['crm médico']}', '#{r['crm médico estado']}', '#{r['nome médico']}',
                          '#{r['email médico']}', '#{r['token resultado exame']}', '#{r['data exame']}',
                          '#{r['tipo exame']}', '#{r['limites tipo exame']}',
                          '#{r['resultado tipo exame']}')"
                 )
    end
  end

  def all
    exams = @conn.exec('SELECT * FROM EXAMS LIMIT 300')
    exams.map { |e| e }
  end
end