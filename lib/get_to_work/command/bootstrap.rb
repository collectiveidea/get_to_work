class GetToWork::Command::Bootstrap < GetToWork::Command
  def run(opts={})

    @cli.say "\n\nStep 1: Pivotal Tracker Setup", :green
    @cli.say "-----------------------------", :green
    pt_username = @cli.ask "Pivotal Tracker Username:"
    pt_password = @cli.ask "Pivotal Tracker Password:", echo: false
  end
end
