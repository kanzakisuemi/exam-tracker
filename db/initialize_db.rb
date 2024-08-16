require 'pg'
require 'csv'
require 'date'

require_relative 'database'
require_relative 'data_inserter'
require_relative 'csv_processor'
require_relative 'data_fetcher'
require_relative 'result_formatter'

CsvProcessor.process_csv_file(File.read(File.join(__dir__, 'data.csv')))
