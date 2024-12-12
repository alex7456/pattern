 class StudentsListYAML < StudentsListBase
  def load_from_file
    if File.exist?(@file_path)
      file_content = File.read(@file_path)
      data = YAML.load(file_content)
      @students = data.map do |student_data|
        Student.new(
          first_name: student_data[:first_name],
          last_name: student_data[:last_name],
          surname: student_data[:surname],
          phone: student_data[:phone],
          telegram: student_data[:telegram],
          email: student_data[:email],
          git: student_data[:git],
          birthdate: student_data[:birthdate],
          id: student_data[:id]
        )
      end
    else
      @students = []
    end
  end

  def save_to_file
    serialized_data = @students.map do |student|
      {
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        surname: student.surname,
        contact:student.contact,
        git: student.git,
        birthdate: student.birthdate
      }
    end
    File.open(@file_path, 'w') { |file| file.write(YAML.dump(serialized_data)) }
  end
end
