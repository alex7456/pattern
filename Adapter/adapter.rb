class Adapter

  def find_student_by_id(id)
    raise NotImplementedError, 'Method not implemented'
  end

  def get_k_n_student_short_list(k, n)
    raise NotImplementedError, 'Method not implemented'
  end

  def add_student(student)
    raise NotImplementedError, 'Method not implemented'
  end

  def update_student_by_id(id, updated_student)
    raise NotImplementedError, 'Method not implemented'
  end

  def delete_student_by_id(id)
    raise NotImplementedError, 'Method not implemented'
  end

  def get_student_count
    raise NotImplementedError, 'Method not implemented'
  end
end
