require 'sidekiq'
require '/app/db/initialize_db'
require 'csv'

class Job
  include Sidekiq::Job

  def perform(csv_content)
    Database.process_csv_file(csv_content)
  end
end
