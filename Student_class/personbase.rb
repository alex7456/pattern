class Human
  attr_reader :id, :github

  GITHUB_REGEX = /^https?:\/\/github\.com\/[a-zA-Z0-9_-]+$/
  ID_REGEX = /^\d+$/

  def initialize(id: nil, github: nil)
    self.id = id if id
    self.github = github if github
  end

  def self.valid_id?(id)
    id=~ID_REGEX
  end

  def self.valid_github?(github)
    github =~ GITHUB_REGEX
  end

  private def id=(value)
    @id = value
  end

  private def github=(value)
    @github = value
  end
  protected def github_present?(github)
    !github.nil? && !github.empty?
  end
  protected def contact
    raise(NotImplementedError)
  end
  protected def validate?
    raise(NotImplementedError)
  end
end
