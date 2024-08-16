require 'sidekiq'
require '/app/db/initialize_db'
require 'csv'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

class CsvJob
  include Sidekiq::Worker

  def perform(csv_content)
    CsvProcessor.process_csv_file(csv_content)
  end
end

