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
    pt_password = @cli.ask "Pivotal Tracker Password:"

    @cli.say "Authenticating with Pivotal Tracker...", :magenta
    token = PivotalTracker::Client.token(pt_username, pt_password)
    
    keychain_item = update_or_create_keychain_item(
      service: KEYCHAIN_SERVICE,
      account: pt_username,
      password: token
    )
  end

  def update_or_create_keychain_item(opts={})
    keychain_items = Keychain.generic_passwords.where(
      service: opts[:service]
    )

    if item = keychain_items.first
      item.open
      item.account = opts[:account]
      item.password = opts[:password]
    else
      create_keychain_item(opts)
    end

  end

  def create_keychain_item(opts={})
    @cli.say "Creating new Keychain item: #{opts[:service]}"
    Keychain.generic_passwords.create(opts)
  end

end
