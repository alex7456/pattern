require_relative './FilterDecorator'

class EmptyGithubFilter < FilterDecorator
  def apply_filter(data)
    super(data).select { |student| student.git.nil? || student.git == '' }
  end
end
