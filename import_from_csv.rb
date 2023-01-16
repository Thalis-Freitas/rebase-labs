require './database'

db = Database.new
db.drop_exams_table
db.create_exams_table
ImportCsv.import('./data.csv', db)
db.close
puts 'Importação de dados finalizada!'