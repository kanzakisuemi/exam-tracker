module ResultFormatter
  def self.format_for_token(results)
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

  def self.format_for_cpf(results)
    patient_info = {
      cpf: results.first['cpf'],
      name: results.first['name'],
      email: results.first['email'],
      birthday: results.first['birthday'],
      address: results.first['address'],
      city: results.first['city'],
      state: results.first['state']
    }

    batteries = results.group_by { |row| row['battery_token'] }.map do |token, rows|
      {
        battery_token: token,
        battery_date: rows.first['result_date'],
        doctor: {
          crm: rows.first['crm'],
          crm_state: rows.first['crm_state'],
          name: rows.first['doctor_name'],
          email: rows.first['doctor_email']
        },
        exams: rows.map do |row|
          {
            type: row['exam_type'],
            range: row['exam_type_range'],
            result: row['exam_result']
          }
        end
      }
    end

    {
      patient: patient_info,
      batteries: batteries
    }
  end

  def self.fetch_formatted_exams_by_token(token)
    results = DataFetcher.fetch_raw_exams_by_token(token)
    format_for_token(results).first
  end

  def self.fetch_formatted_exams
    results = DataFetcher.fetch_raw_exams
    format_for_token(results)
  end

  def self.fetch_formatted_exams_by_cpf(cpf)
    results = DataFetcher.fetch_raw_exams_by_cpf(cpf)
    format_for_cpf(results)
  end
end
