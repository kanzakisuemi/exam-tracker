require 'pg'

class ExamResult
  def initialize
    @conn = PG.connect(host: 'db', dbname: 'exam_db', user: 'user', password: 'password')
  end

  def all
    result = @conn.exec('SELECT * FROM exam_results')
    result.map { |row| row }
  end

  def self.all
    new.all
  end
end
