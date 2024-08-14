require 'pg'

class Patient
  def initialize
    @conn = PG.connect(host: 'db', dbname: 'exam_db', user: 'user', password: 'password')
  end

  def all
    result = @conn.exec('SELECT * FROM patients')
    result.map { |row| row }
  end

  def self.all
    new.all
  end
end
