class GetToWork::Service::PivotalTracker < GetToWork::Service
  def initialize
    @name = "PivotalTracker"
    @display_name = "Pivotal Tracker"
  end

  def authenticate(username:, password:)
    @api_token = ::PivotalTracker::Client.token(username, password)
  end

  def get_projects
    ::PivotalTracker::Project.all
  end
end
