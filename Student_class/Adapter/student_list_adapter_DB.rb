require_relative './adapter'

class Students_list_db_adapter < Adapter
  def initialize(db_config)
    @db = Connection.instance(db_config)
  end

  def find_student_by_id(id)
    result = @db.execute_query("SELECT * FROM student WHERE id = #{id}")
    return nil if result.ntuples.zero?

    row = result[0]
    Student.from_hash(
      id: row['id'].to_i,
      lastname: row['last_name'],
      firstname: row['first_name'],
      surname: row['surname'],
      phone: row['phone'],
      email: row['email'],
      telegram: row['telegram'],
      github: row['github'],
      birth_date: row['birth_date']
    )
  end

  def get_k_n_student_short_list(k, n)
    start_index = (k - 1) * n
    query = "
      SELECT * FROM student
      OFFSET #{start_index} LIMIT #{n}
    "
    result = @db.execute_query(query)
    students = result.map do |row|
      Student.from_hash(
        id: row['id'].to_i,
        lastname: row['last_name'],
        firstname: row['first_name'],
        surname: row['surname'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        github: row['github'],
        birth_date: row['birth_date']
      )
    end
    short_students = students.map { |student| Student_short.from_student(student) }
    Data_list_student_short.new(short_students)
  end

  def add_student(student)
    query = "
      INSERT INTO student (last_name, first_name, surname, phone, email, telegram, github, birth_date)
      VALUES (
        '#{student.last_name}', '#{student.first_name}', '#{student.surname}',
        #{student.phone.nil? ? 'NULL' : "'#{student.phone}'"},
        #{student.email.nil? ? 'NULL' : "'#{student.email}'"},
        #{student.telegram.nil? ? 'NULL' : "'#{student.telegram}'"},
        #{student.git.nil? ? 'NULL' : "'#{student.git}'"},
        '#{student.birthdate}'
      )
    "
    @db.execute_query(query)
  end

  def update_student_by_id(id, updated_student)
    query = "
      UPDATE student
      SET last_name = '#{updated_student.last_name}',
          first_name = '#{updated_student.first_name}',
          surname = '#{updated_student.surname}',
          phone = #{updated_student.phone.nil? ? 'NULL' : "'#{updated_student.phone}'"},
          email = #{updated_student.email.nil? ? 'NULL' : "'#{updated_student.email}'"},
          telegram = #{updated_student.telegram.nil? ? 'NULL' : "'#{updated_student.telegram}'"},
          github = #{updated_student.git.nil? ? 'NULL' : "'#{updated_student.git}'"},
          birth_date = '#{updated_student.birthdate}'
      WHERE id = #{id}
    "
    @db.execute_query(query)
  end

  def delete_student_by_id(id)
    @db.execute_query("DELETE FROM student WHERE id = #{id}")
  end

  def get_student_short_count
    result = @db.execute_query('SELECT COUNT(*) FROM student')
    result[0]['count'].to_i
  end
end
