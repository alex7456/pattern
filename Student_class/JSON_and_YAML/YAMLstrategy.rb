require 'yaml'
require_relative 'file_strategy'
class YAMLStrategy < FileStrategy
  def load(file_path)
    return [] unless File.exist?(file_path)

    data = YAML.load(File.read(file_path))
    data.map do |student_data|
      Student.new(
        first_name: student_data[:first_name],
        last_name: student_data[:last_name],
        surname: student_data[:surname],
        phone: student_data[:phone],
        telegram: student_data[:telegram],
        email: student_data[:email],
        github: student_data[:github],
        birthdate: student_data[:birthdate],
        id: student_data[:id]
      )
    end
  end

  def save(file_path, students)
    serialized_data = students.map do |student|
      {
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        surname: student.surname,
        contact: student.contact,
        github: student.github,
        birthdate: student.birthdate
      }
    end
    File.write(file_path, YAML.dump(serialized_data))
  end
end
