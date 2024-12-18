require_relative '../Entities/Student'
require_relative '../Entities/Student_short'
require_relative '../DataList/data_list_student_short'
require_relative '../Database/connection'

class Students_list_DB
  @instance = nil

  # Метод класса для получения единственного экземпляра
  def self.instance(db_connection = nil)
    return @instance if @instance

    raise 'DB connection is required for the first initialization' if db_connection.nil?

    @instance = new(db_connection)
  end

  private_class_method :new

  def initialize(db_connection)
    @db = db_connection
  end

  # Fetch a single student by ID
  def find_student_by_id(id)
    result = @db.execute_query("SELECT * FROM student WHERE id = #{id}")
    return nil if result.ntuples == 0

    row = result[0]
    Student.new(
      id: row['id'].to_i,
      last_name: row['last_name'],
      first_name: row['first_name'],
      surname: row['surname'],
      phone: row['phone'],
      email: row['email'],
      telegram: row['telegram'],
      git: row['github'],
      birthdate: row['birth_date']
    )
  end

  # Get a paginated list of students
  def get_k_n_student_short_list(k, n)
    start_index = (k - 1) * n + 1
    end_index = start_index + n - 1

    query = "SELECT * FROM student WHERE id BETWEEN #{start_index} AND #{end_index}"
    result = @db.execute_query(query)

    students = result.map do |row|
      Student.new(
        id: row['id'].to_i,
        last_name: row['last_name'],
        first_name: row['first_name'],
        surname: row['surname'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        git: row['github'],
        birthdate: row['birth_date']
      )
    end

    short_students = students.map { |student| Student_short.from_student(student) }
    selected_list = Data_list_student_short.new(short_students)
    short_students.each_with_index { |_, index| selected_list.select(index) }
    selected_list
  end

  # Add a new student to the database
  def add_student(student)
    query = "
      INSERT INTO student (last_name, first_name, surname, phone, email, telegram, github, birth_date)
      VALUES ('#{student.last_name}', '#{student.first_name}', '#{student.surname}',
              #{student.phone.nil? ? 'NULL' : "'#{student.phone}'"},
              #{student.email.nil? ? 'NULL' : "'#{student.email}'"},
              #{student.telegram.nil? ? 'NULL' : "'#{student.telegram}'"},
              #{student.git.nil? ? 'NULL' : "'#{student.git}'"},
              '#{student.birthdate}')
    "
    @db.execute_query(query)
  end

  # Update student details by ID
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

  # Delete a student by ID
  def delete_student_by_id(id)
    @db.execute_query("DELETE FROM student WHERE id = #{id}")
  end

  # Get the total count of students
  def get_student_count
    result = @db.execute_query('SELECT COUNT(*) FROM student')
    result[0]['count'].to_i
  end
end
