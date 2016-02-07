require "yaml"
require "singleton"

class GetToWork::ConfigFile
  include Singleton

  def initialize
    setup_data(self.class.path)
  end

  def setup_data(path)
    @data = begin
      YAML.load_file(path)
    rescue Errno::ENOENT
      {}
    end

    puts @data
  end

  def self.exist?
    File.exist? path
  end

  def self.path
    File.join(Dir.pwd, filename)
  end

  def self.filename
    ".get-to-work"
  end
end
