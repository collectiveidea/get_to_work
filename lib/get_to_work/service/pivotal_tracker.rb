class GetToWork::Service::PivotalTracker < GetToWork::Service
  @yaml_key = "pivotal_tracker"
  @name = "PivotalTracker"
  @display_name = "Pivotal Tracker"

  def authenticate(username:, password:, service: _)
    @api_token = ::PivotalTracker::Client.token(username, password)
  end

  def authenticate_with_keychain
    if the_keychain = keychain
      set_client_token(the_keychain.password)
    end
  end

  def set_client_token(token)
    api_client.token = token
  end

  def api_client
    ::PivotalTracker::Client
  end

  def projects
    @projects ||= get_projects
  end

  def get_projects
    ::PivotalTracker::Project.all
  end
end
