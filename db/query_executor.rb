class QueryExecutor
  def initialize(conn)
    @conn = conn
  end

  def fetch_raw_exams
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

    results = @conn.exec(query)
    results.map { |row| row }
  end

  def fetch_raw_exams_by_token(token)
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

    results = @conn.exec_params(query, [token])
    results.map { |row| row }
  end

  def format_results(results)
    results.group_by { |row| [row['result_token'], row['result_date'], row['cpf']] }.map do |(token, date, cpf), rows|
      {
        "result_token" => token,
        "result_date" => date,
        "cpf" => cpf,
        "name" => rows.first['name'],
        "email" => rows.first['email'],
        "birthday" => rows.first['birthday'],
        "doctor" => {
          "crm" => rows.first['crm'],
          "crm_state" => rows.first['crm_state'],
          "name" => rows.first['doctor_name']
        },
        "exams" => rows.map do |row|
          {
            "type" => row['exam_type'],
            "limits" => row['exam_type_range'],
            "result" => row['exam_result']
          }
        end
      }
    end
  end

  def fetch_formatted_exams_by_token(token)
    results = fetch_raw_exams_by_token(token)
    format_results(results).first
  end

  def fetch_formatted_exams
    results = fetch_raw_exams
    format_results(results)
  end
end

