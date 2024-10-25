require_relative 'Student'
class StudentShort < PersonBase
  attr_reader :fio, :contact

  def self.from_student(student)
    new(id: student.id, git: student.git, fio: "#{student.surname} #{student.initials}", contact: student.get_contact)
  end

  def self.from_string(id:, student_str:)
    info_arr = student_str.split("\t")
    new(id: id, git: info_arr[1], fio: info_arr[0], contact: info_arr[2])
  end

  def initialize(id:, git: nil, fio:, contact: nil)
    super(id: id, git: git)
    self.fio = fio
    self.contact = contact
  end

  def fio=(value)
    set_attribute(:fio, value)
  end

  def contact=(value)
    set_attribute(:contact, value)
  end
end
