require 'pg'

class DBConnection
  def self.connect
    params = {
      host: 'db',
      dbname: 'exam_db',
      user: 'user',
      password: 'password'
    }
    PG.connect(params)
  end
end
