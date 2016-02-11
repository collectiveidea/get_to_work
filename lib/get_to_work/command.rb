require "keychain"

module GetToWork
  class Command
    def self.run(opts = {})
      trap("SIGINT") { exit! }
      new(opts).run
    end

    def initialize(cli: nil, pt_id:nil)
      @cli = cli
      @pt_id = pt_id
    end

    def run
    end
  end
end
