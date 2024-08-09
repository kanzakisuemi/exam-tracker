require 'pg'

class Exam
  def initialize
    @conn = PG.connect(host: 'db', dbname: 'exam_db', user: 'user', password: 'password')
  end

  def all
    result = @conn.exec("SELECT * FROM exams")
    result.map { |row| row }.to_json
  end

  def self.all
    new.all
  end
end
