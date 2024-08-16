module CsvProcessor
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

  def self.process_csv_file(csv_file)
    conn = Database.connect_to_db
    Database.create_all_tables(conn)
    DataInserter.insert_data(read_from_csv(csv_file), conn)
  end
end
