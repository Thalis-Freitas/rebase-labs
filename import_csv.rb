require 'csv'
require_relative './database'

class ImportCsv
  def self.csv_data(csv)
    rows = CSV.read(csv, col_sep: ';')
    columns = rows.shift

    rows.map do |row|
      row.each_with_object({}).with_index do |(cell, acc), idx|
        column = columns[idx]
        acc[column] = cell
      end
    end
  end

  def self.import(csv, db)
    db.insert_exams_records(csv)
  end
end