class PersonBase
  attr_reader :id, :git

  # Инициализация с установкой ID и Git
  def initialize(id: nil, git: nil)
    self.id = id.to_i unless id.nil?
    set_attribute(:git, git) if git
  end

  def to_s
    instance_variables.map do |key|
      val = instance_variable_get(key)
      key_name = key.to_s.delete_prefix('@')
      "#{key_name}: #{val}" unless val.nil? || val.to_s.empty?
    end.compact.join("\n")
  end

  private

  def set_attribute(attr_name, value)
    regex_map = {
      git: /\A[a-zA-Z0-9._-]+\z/,
      email: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
      phone: /\A\d{1,3}-\d{3}-\d{3}\z/,
      telegram: /\A[a-zA-Z0-9_]{5,}\z/,
	  first_name: /\A[А-Яа-яЁёA-Za-z]+\z/,   
      surname: /\A[А-Яа-яЁёA-Za-z]+\z/,    
      last_name: /\A[А-Яа-яЁёA-Za-z]+\z/,
	  fio: /\A[А-Яа-яЁёA-Za-z]+\s[А-Яа-яЁёA-Za-z]\.[А-Яа-яЁёA-Za-z]\.\z/,
	  contact: /\A.+\z/
    }

    regex = regex_map[attr_name]
    raise ArgumentError, "Validation not defined for #{attr_name}" unless regex

    if value.nil? || value.empty? || value.match?(regex)
      instance_variable_set("@#{attr_name}", value)
    else
      raise ArgumentError, "Incorrect #{attr_name}: #{value}"
    end
  end

  def id=(id)
    raise ArgumentError, "Invalid ID" if id.nil? || id.to_s.empty? || id.to_s.match?(/\D/)
    @id = id
  end
end
