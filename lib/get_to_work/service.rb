class GetToWork::Service
  attr_reader :api_token

  class << self
    attr_accessor :yaml_key, :name, :display_name
  end

  def yaml_key
    self.class.yaml_key
  end

  def name
    self.class.name
  end

  def display_name
    self.class.display_name
  end

  def initialize(data_hash=nil)
    return if data_hash.nil?
    
    @data = data_hash[self.yaml_key]
    @data.each { |name, value| instance_variable_set("@#{name}", value) }

    authenticate_with_keychain
  end

  def update_keychain(account:)
    raise "@api_token not set for #{self.name}" if @api_token.nil?
    raise "@name not set for #{self.name}" if @api_token.nil?

    keychain_item = GetToWork::Keychain.new.update(
      service: self.class.name,
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
