module GetToWork
  KEYCHAIN_PREFIX = "GetToWork".freeze

  class Keychain
    def update(opts = {})
      relative_service_name = opts[:service]
      @absolute_service_name =
        self.class.absolute_service_name(relative_service_name)

      update_or_create_keychain_item(opts)
    end

    def self.find(service:)
      ::Keychain.generic_passwords.where(
        service: absolute_service_name(service)
      ).all
    end

    class <<self
      private

      def self.absolute_service_name(relative_name)
        "#{KEYCHAIN_PREFIX}::#{relative_name}"
      end
    end

    private

    def update_or_create_keychain_item(opts = {})
      keychain_items = self.class.find(service: opts[:service])
      ::Keychain.generic_passwords.where(
        service: @absolute_service_name
      )

      if item = keychain_items.first
        item.account = opts[:account]
        item.password = opts[:password]
      else
        create_keychain_item(opts)
      end
    end

    def create_keychain_item(opts = {})
      relative_service_name = opts[:service]
      opts[:service] = self.class.absolute_service_name(relative_service_name)

      ::Keychain.generic_passwords.create(opts)
    end
  end
end
