require 'csv'
require 'date'

module CSVProcessor
  def self.read_from_csv(file)
    rows = CSV.parse(file, col_sep: ';')
    columns = rows.shift
    rows.map do |row|
      row_hash = {}
      row.each_with_index do |cell, index|
        column_name = columns[index]
        row_hash[column_name] = cell
      end
      row_hash
    end
  end
end

