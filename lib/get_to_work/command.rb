require "keychain"

module GetToWork
  class Command

    def self.run(opts={})
      trap("SIGINT") { exit! }
      new(opts).run
    end

    def initialize(cli: nil)
      @cli = cli
    end

    def run
    end
  end
end
