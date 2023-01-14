require 'sidekiq'

class ImporterJob
  include Sidekiq::Job

  def perform(csv)
    sleep 5
    ImportDataCsv.new.insert_records(csv)
    puts 'Dados registrados com sucesso!'
  end
end
