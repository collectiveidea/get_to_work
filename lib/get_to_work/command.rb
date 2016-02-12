require "keychain"

module GetToWork
  class Command
    def self.run(opts = {})
      trap("SIGINT") { exit! }
      new(opts).run
    end

    def initialize(opts = {})
      @cli = opts[:cli]
    end

    def config_file
      ConfigFile.instance
    end

    def last_timer
      config_file["last_timer"]
    end

    def last_story
      config_fild["last_story"]
    end

    def harvest_service
      @harvest ||= GetToWork::Service::Harvest.new(
        GetToWork::ConfigFile.instance.data
      )
    end

    def run
    end
  end
end
