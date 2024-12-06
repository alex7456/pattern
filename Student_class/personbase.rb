class Human
  attr_reader :id , :git
  ID_REGEX = /^\d+$/
  GIT_REGEX = /^https?:\/\/github\.com\/[a-zA-Z0-9_-]+$/
  def initialize(id:nil, git:nil)
    self.id = id if id
    self.git = git if git
  end
  private def id=(value)
    if self.class.valid_id?(value)
    @id = value
    else
      raise ArgumentError, "id is not valid"
  end
    end
  private def git=(value)
    if self.class.valid_git?(value)
      @git = value
      else raise ArgumentError, "git is not valid"
    end

    end

  def self.valid_id?(id)
     ID_REGEX.match?(id.to_s)
  end
  def self.valid_git?(git)
    GIT_REGEX.match?(git)
  end
  protected def git_present?(git)
    !git.nil? && !git.empty?
  end
  protected def validate?
    raise NotImplementedError
  end
  protected def contact?
    raise NotImplementedError
  end
  end
