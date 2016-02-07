require "pivotal-tracker"

class GetToWork::Command::Bootstrap < GetToWork::Command
  KEYCHAIN_SERVICE = "GetToWork::PivotalTracker"

  def run(opts={})
    pt = GetToWork::Service::PivotalTracker.new

    @cli.say "\n\nStep #{pt.display_name} Setup", :green
    @cli.say "-----------------------------", :green

    prompt_for_login(pt)
    prompt_select_project(pt)
  end

  def prompt_for_login(service)
    username = @cli.ask "#{service.display_name} Username:"
    password = @cli.ask "#{service.display_name} Password:"

    @cli.say "\n\nAuthenticating with #{service.display_name}...", :magenta

    begin
      service.authenticate(username: username, password: password)
      puts service.inspect
    rescue RestClient::Unauthorized
      @cli.say "Could not authenticate with #{service.display_name}", :red
      exit(1)
    end

    service.update_keychain(account: username)
  end

  def prompt_select_project(service)
    service.get_projects
  end
end
