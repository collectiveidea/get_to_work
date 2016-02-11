require 'harvested'

class GetToWork::Service::Harvest < GetToWork::Service
  @yaml_key = "harvest"
  @name = "Harvest"
  @display_name = "Harvest"

  attr_reader :subdomain, :project_id, :task_id
  def initialize(yaml_hash)
    super(yaml_hash)

    @harvest = nil
  end

  def api_client
    @api_client ||= ::Harvest.client(
      subdomain: @subdomain,
      username: keychain.account,
      password: keychain.password
    )
  end

  def authenticate_with_keychain
    if !@subdomain.blank? && keychain
      return api_client
    end
  end

  def authenticate(username:, password:, subdomain:)
    @subdomain = subdomain
    @api_client = ::Harvest.client(
      subdomain: @subdomain,
      username: username,
      password: password
    )

    if @api_client
      @api_token = password
    end
  end

  def clients
    @clients ||= get_clients
  end

  def get_clients
    api_client.clients.all
  end

  def get_time
    api_client.time
  end

  def projects
    api_client.time.trackable_projects
  end

  def project
    projects.find(@project_id)
  end

  def start_timer(opts = {})
    api_client.time.create(opts)
  end
end
