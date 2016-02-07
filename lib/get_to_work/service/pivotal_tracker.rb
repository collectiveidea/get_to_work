class GetToWork::Service::PivotalTracker < GetToWork::Service
  def initialize
    @name = "PivotalTracker"
    @display_name = "Pivotal Tracker"
  end

  def authenticate(username:, password:)
    @api_token = ::PivotalTracker::Client.token(username, password)
  end

  def api_token
    if @api_token.nil?
      @api_token = keychains.last.password
      ::PivotalTracker::Client.token = @api_token
    end

    @api_token
  end

  def projects
    @projects ||= get_projects
  end

  def get_projects
    ::PivotalTracker::Project.all
  end
end
