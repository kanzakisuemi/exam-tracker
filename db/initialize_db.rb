require 'pg'
require 'csv'
require 'date'

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
                 cpf CHAR(20) UNIQUE NOT NULL,
                 name VARCHAR(150),
                 email VARCHAR(150),
                 birthday DATE,
                 address VARCHAR(300),
                 city VARCHAR(150),
                 state VARCHAR(100)
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
                 token VARCHAR(14) UNIQUE NOT NULL,
                 date DATE
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

  def self.insert_data(data, conn)
    data.each do |row|
      insert_patient(row, conn)
      insert_doctor(row, conn)
      insert_exam(row, conn)
      insert_exam_result(row, conn)
    end
  end

  def self.insert_patient(row, conn)
    patient_result = conn.exec_params(
      'SELECT id FROM patients WHERE cpf = $1 LIMIT 1',
      [row['cpf']]
    )
    if patient_result.num_tuples.zero?
      conn.exec_params(
        'INSERT INTO patients (cpf, name, email, birthday, address, city, state)
         VALUES ($1, $2, $3, $4, $5, $6, $7)',
        [
          row['cpf'],
          row['nome paciente'],
          row['email paciente'],
          Date.parse(row['data nascimento paciente']),
          row['endereço/rua paciente'],
          row['cidade paciente'],
          row['estado patiente']
        ]
      )
    end
  end

  def self.insert_doctor(row, conn)
    doctor_result = conn.exec_params(
      'SELECT id FROM doctors WHERE crm = $1 LIMIT 1',
      [row['crm médico']]
    )
    if doctor_result.num_tuples.zero?
      conn.exec_params(
        'INSERT INTO doctors (crm, crm_state, name, email)
         VALUES ($1, $2, $3, $4)',
        [
          row['crm médico'],
          row['crm médico estado'],
          row['nome médico'],
          row['email médico']
        ]
      )
    end
  end

  def self.insert_exam(row, conn)
    exam_result = conn.exec_params(
      'SELECT id FROM exams WHERE token = $1 LIMIT 1',
      [row['token resultado exame']]
    )
    if exam_result.num_tuples.zero?
      conn.exec_params(
        'INSERT INTO exams (id_patient, id_doctor, token, date)
         VALUES (
           (SELECT id FROM patients WHERE cpf = $1),
           (SELECT id FROM doctors WHERE crm = $2),
           $3,
           $4
         )',
        [
          row['cpf'],
          row['crm médico'],
          row['token resultado exame'],
          Date.parse(row['data exame'])
        ]
      )
    end
  end

  def self.insert_exam_result(row, conn)
    id_exam_result = conn.exec_params(
      'SELECT id FROM exams WHERE token = $1 LIMIT 1',
      [row['token resultado exame']]
    )[0]['id'].to_i

    result_exists = conn.exec_params(
      'SELECT * FROM exam_results WHERE id_exam = $1 AND type = $2 LIMIT 1',
      [id_exam_result, row['tipo exame']]
    ).num_tuples.zero?
    if result_exists
      conn.exec_params(
        'INSERT INTO exam_results (id_exam, type, limits, result)
         VALUES ($1, $2, $3, $4)',
        [
          id_exam_result,
          row['tipo exame'],
          row['limites tipo exame'],
          row['resultado tipo exame']
        ]
      )
    end
  end

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
    conn = connect_to_db
    create_all_tables(conn)
    insert_data(read_from_csv(csv_file), conn)
  end
end

Database.process_csv_file(File.read('db/data.csv'))
