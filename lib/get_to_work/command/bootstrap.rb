require "pivotal-tracker"

class GetToWork::Command::Bootstrap < GetToWork::Command
  KEYCHAIN_SERVICE = "GetToWork::PivotalTracker"

  def run(opts={})
    prompt_for_credentials
  end

  def prompt_for_credentials
    @cli.say "\n\nStep 1: Pivotal Tracker Setup", :green
    @cli.say "-----------------------------", :green
    pt_username = @cli.ask "Pivotal Tracker Username:"
    pt_password = @cli.ask "Pivotal Tracker Password:", echo: "-"

    @cli.say "\n\nAuthenticating with Pivotal Tracker...", :magenta

    begin
      token = PivotalTracker::Client.token(pt_username, pt_password)
    rescue RestClient::Unauthorized
      @cli.say "Could not authenticate with Pivotal Tracker", :red
      exit(1)
    end

    keychain_item = GetToWork::Keychain.new(cli: @cli).update(
      service: "PivotalTracker",
      account: pt_username,
      password: token
    )
  end
end
