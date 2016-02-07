module GetToWork
  KEYCHAIN_PREFIX = "GetToWork"
  class Keychain
    def initialize(cli: nil)
      @cli = cli
    end

    def update(opts={})
      opts[:service] = "#{KEYCHAIN_PREFIX}::#{opts[:service]}"
      update_or_create_keychain_item(opts)
    end

    private

    def update_or_create_keychain_item(opts={})
      keychain_items = ::Keychain.generic_passwords.where(
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
      ::Keychain.generic_passwords.create(opts)
    end
  end
end
