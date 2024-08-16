module Database
  def self.connect_to_db
    params = {
      host: 'db',
      dbname: 'exam_db',
      user: 'user',
      password: 'password'
    }
    PG.connect(params)
  end

  def self.create_all_tables(conn)
    create_patients_table(conn)
    create_doctors_table(conn)
    create_exams_table(conn)
    create_exam_results_table(conn)
  end

  private

  def self.create_patients_table(conn)
    conn.exec('CREATE TABLE IF NOT EXISTS patients (
                 id SERIAL PRIMARY KEY,
                 cpf CHAR(14) UNIQUE NOT NULL,
                 name VARCHAR(150),
                 email VARCHAR(150),
                 birthday DATE,
                 address VARCHAR(300),
                 city VARCHAR(80),
                 state VARCHAR(80)
               )')
  end

  def self.create_doctors_table(conn)
    conn.exec('CREATE TABLE IF NOT EXISTS doctors (
                 id SERIAL PRIMARY KEY,
                 crm VARCHAR(15) UNIQUE NOT NULL,
                 crm_state CHAR(2),
                 name VARCHAR(150),
                 email VARCHAR(150)
               )')
  end

  def self.create_exams_table(conn)
    conn.exec('CREATE TABLE IF NOT EXISTS exams (
                 id SERIAL PRIMARY KEY,
                 id_patient INTEGER REFERENCES patients (id),
                 id_doctor INTEGER REFERENCES doctors (id),
                 token VARCHAR(14) NOT NULL,
                 type VARCHAR(150) NOT NULL,
                 date DATE,
                 UNIQUE (token, type, date)
               )')
  end

  def self.create_exam_results_table(conn)
    conn.exec('CREATE TABLE IF NOT EXISTS exam_results (
                 id SERIAL PRIMARY KEY,
                 id_exam INTEGER REFERENCES exams (id),
                 type VARCHAR(150),
                 limits VARCHAR(15),
                 result VARCHAR(10),
                 UNIQUE (id_exam, type)
               )')
  end
end

