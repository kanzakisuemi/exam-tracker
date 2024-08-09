# frozen_string_literal: true

require 'csv'
require 'pg'

conn = PG.connect(host: 'db', dbname: 'exam_db', user: 'user', password: 'password')
conn.exec("
  CREATE TABLE IF NOT EXISTS exams (
    exam_id SERIAL PRIMARY KEY,
    cpf VARCHAR (20) NOT NULL,
    patient_name VARCHAR (50) NOT NULL,
    patient_mail VARCHAR (50) NOT NULL,
    patient_birthdate TIMESTAMP NOT NULL,
    patient_adress VARCHAR (100) NOT NULL,
    patient_city VARCHAR (50) NOT NULL,
    patient_state VARCHAR (50) NOT NULL,
    medic_crm VARCHAR (50) NOT NULL,
    medic_crm_state VARCHAR (2) NOT NULL,
    medic_name VARCHAR (50) NOT NULL,
    medic_mail VARCHAR (50) NOT NULL,
    exam_token VARCHAR (50) NOT NULL,
    exam_date TIMESTAMP NOT NULL,
    exam_type VARCHAR (50) NOT NULL,
    exam_type_range VARCHAR (50) NOT NULL,
    exam_result VARCHAR (10) NOT NULL
  )
")

rows = CSV.read('db/data.csv', col_sep: ';')
rows.shift

rows.each do |row|
  conn.exec("
    INSERT INTO exams (
    cpf, patient_name, patient_mail, patient_birthdate,
    patient_adress, patient_city, patient_state, medic_crm,
    medic_crm_state, medic_name, medic_mail, exam_token, exam_date,
    exam_type, exam_type_range, exam_result)
    VALUES  ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)
  ", row)
end
