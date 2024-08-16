module DataInserter
  def self.insert_data(data, conn)
    data.each do |row|
      insert_patient(row, conn)
      insert_doctor(row, conn)
      insert_exam(row, conn)
      insert_exam_result(row, conn)
    end
  end

  def self.insert_patient(row, conn)
    conn.exec_params(
      'INSERT INTO patients (cpf, name, email, birthday, address, city, state)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       ON CONFLICT (cpf) DO NOTHING',
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

  def self.insert_doctor(row, conn)
    conn.exec_params(
      'INSERT INTO doctors (crm, crm_state, name, email)
       VALUES ($1, $2, $3, $4)
       ON CONFLICT (crm) DO NOTHING',
      [
        row['crm médico'],
        row['crm médico estado'],
        row['nome médico'],
        row['email médico']
      ]
    )
  end

  def self.insert_exam(row, conn)
    conn.exec_params(
      'INSERT INTO exams (id_patient, id_doctor, token, type, date)
       VALUES (
         (SELECT id FROM patients WHERE cpf = $1),
         (SELECT id FROM doctors WHERE crm = $2),
         $3,
         $4,
         $5
       )
       ON CONFLICT (token, type, date) DO NOTHING',
      [
        row['cpf'],
        row['crm médico'],
        row['token resultado exame'],
        row['tipo exame'],
        Date.parse(row['data exame'])
      ]
    )
  end

  def self.insert_exam_result(row, conn)
    id_exam_result = conn.exec_params(
      'SELECT id FROM exams WHERE token = $1 AND type = $2 AND date = $3 LIMIT 1',
      [row['token resultado exame'], row['tipo exame'], Date.parse(row['data exame'])]
    )[0]['id'].to_i

    conn.exec_params(
      'INSERT INTO exam_results (id_exam, type, limits, result)
       VALUES ($1, $2, $3, $4)
       ON CONFLICT (id_exam, type) DO NOTHING',
      [
        id_exam_result,
        row['tipo exame'],
        row['limites tipo exame'],
        row['resultado tipo exame']
      ]
    )
  end
end

