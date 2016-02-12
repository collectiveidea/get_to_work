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

    def run
    end
  end
end
