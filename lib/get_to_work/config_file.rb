require "yaml"

class GetToWork::ConfigFile

  def self.find(path: self.path)
    new(path)
  end

  def initialize(path)
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
