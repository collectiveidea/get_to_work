require "pivotal-tracker"

class GetToWork::Command::Bootstrap < GetToWork::Command
  KEYCHAIN_SERVICE = "GetToWork::PivotalTracker"

  def run(opts={})
    pt = GetToWork::Service::PivotalTracker.new

    @cli.say "\n\nStep #{pt.display_name} Setup", :magenta
    @cli.say "-----------------------------", :magenta

    if pt.api_token.nil?
      prompt_for_login(pt)
    end

    prompt_select_project(pt)
  end

  def prompt_for_login(service)
    username = @cli.ask "#{service.display_name} Username:", :green
    password = @cli.ask "#{service.display_name} Password:", :green

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
    project_options = GetToWork::MenuPresenter.with_collection(service.projects)

    selected_project = @cli.menu_ask(
      "\nSelect a #{service.display_name} project:",
      project_options,
      :green,
      limited_to: project_options.menu_limit
    )

    require "pry"
    binding.pry
  end
end
