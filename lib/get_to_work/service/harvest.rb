require 'harvested'

class GetToWork::Service::Harvest < GetToWork::Service
  def initialize(yaml_hash)
    @yaml_key = "harvest"
    @name = "Harvest"
    @display_name = "Harvest"

    if yaml_hash
      data = yaml_hash[@yaml_key]
      @subdomain = data["subdomain"]
      @client_id = data["client_id"]
      @task_id = data["task_id"]
    else
    end

    @harvest = nil
  end

  def api_client
    @api_client ||= ::Harvest.client(subdomain: @subdomain, username: keychain.account, password: keychain.password)
  end

  def authenticate(username:, password:, subdomain:)
    @subdomain = subdomain
    @api_client = ::Harvest.client(subdomain: @subdomain, username: username, password: password)

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
end
