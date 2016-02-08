class GetToWork::Service
  attr_reader :name, :api_token, :yaml_key
  attr_accessor :display_name

  def update_keychain(account:)
    raise "@api_token not set for #{self.name}" if @api_token.nil?
    raise "@name not set for #{self.name}" if @api_token.nil?

    keychain_item = GetToWork::Keychain.new.update(
      service: @name,
      account: account,
      password: @api_token
    )
  end

  def api_token
    if keychain && @api_token.nil?
      @api_token = keychain.password
      set_client_token(@api_token)
    end

    @api_token
  end

  def set_client_token(token)
    # noop
  end

  def keychain
    @keychain ||= GetToWork::Keychain.find(service: self.name).last
    puts "Keychain: #{@keychain}"
    @keychain
  end

  def save_config(opts)
    config_file = GetToWork::ConfigFile.instance
    config_file[self.yaml_key] = opts
  end
end
