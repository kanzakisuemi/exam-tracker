module ResultFormatter
  def self.format_results(results)
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

  def self.fetch_formatted_exams_by_token(token)
    results = DataFetcher.fetch_raw_exams_by_token(token)
    format_results(results).first
  end

  def self.fetch_formatted_exams
    results = DataFetcher.fetch_raw_exams
    format_results(results)
  end
end
