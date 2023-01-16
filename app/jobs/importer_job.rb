require 'sidekiq'

class ImporterJob
  include Sidekiq::Job

  def perform(csv)
    sleep 5
    Database.new.insert_exams_records(csv)
    puts 'Dados registrados com sucesso!'
  end
end
