module DataFetcher
  def self.fetch_raw_exams
    conn = Database.connect_to_db
    query = <<-SQL
      SELECT
        e.token AS result_token,
        e.date AS result_date,
        p.cpf,
        p.name,
        p.email,
        p.birthday,
        p.address,
        p.city,
        p.state,
        d.crm,
        d.crm_state,
        d.name AS doctor_name,
        d.email AS doctor_email,
        e.type AS exam_type,
        er.limits AS exam_type_range,
        er.result AS exam_result
      FROM exams e
      JOIN patients p ON e.id_patient = p.id
      JOIN doctors d ON e.id_doctor = d.id
      LEFT JOIN exam_results er ON e.id = er.id_exam
    SQL

    results = conn.exec(query)
    conn.close
    results.map { |row| row }
  end

  def self.fetch_raw_exams_by_token(token)
    conn = Database.connect_to_db
    query = <<-SQL
      SELECT
        e.token AS result_token,
        e.date AS result_date,
        p.cpf,
        p.name,
        p.email,
        p.birthday,
        p.address,
        p.city,
        p.state,
        d.crm,
        d.crm_state,
        d.name AS doctor_name,
        d.email AS doctor_email,
        e.type AS exam_type,
        er.limits AS exam_type_range,
        er.result AS exam_result
      FROM exams e
      JOIN patients p ON e.id_patient = p.id
      JOIN doctors d ON e.id_doctor = d.id
      LEFT JOIN exam_results er ON e.id = er.id_exam
      WHERE e.token = $1
    SQL

    results = conn.exec_params(query, [token])
    conn.close
    results.map { |row| row }
  end
end

