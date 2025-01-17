class Human
  attr_reader :id, :github  # <-- Используем `github`, а не `git`
  ID_REGEX = /^\d+$/
  GIT_REGEX = /^https?:\/\/github\.com\/[a-zA-Z0-9_-]+$/

  def initialize(id:nil, github:nil)
    self.id = id if id
    self.github = github if github
  end

  def id=(value)
    if self.class.valid_id?(value)
      @id = value
    else
      raise ArgumentError, "id is not valid"
    end
  end

  private def github=(value)
    if self.class.valid_git?(value)
      @github = value  # <-- Используем `@github`, а не `@git`
    else
      raise ArgumentError, "github is not valid"
    end
  end

  def self.valid_id?(id)
    ID_REGEX.match?(id.to_s)
  end

  def self.valid_git?(github)
    GIT_REGEX.match?(github)
  end

  protected def git_present?(github)
    !github.nil? && !github.empty?
  end
end
