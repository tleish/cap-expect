gem 'capistrano', '~> 2.14.2'
require 'capistrano/configuration'

class FileConfig
  REMOVE = ["require 'ps_deploy_helper/capistrano'", "require 'rvm-capistrano'"]

  attr_reader :filepath, :basename, :attributes
  def initialize(filepath)
    @filepath = filepath
    @basename = File.basename(filepath, '.*')
    @attributes = load

  end

  def load
    @contents = contents
    begin
      config = Capistrano::Configuration.new
      config.load(string: clean_contents)
      config
    rescue LoadError => e
      puts "Warning: LoadError: #{e.message}"
      puts "          " + e.backtrace.grep(/#{@filepath}/).first
    end
  end

  private

  def contents
    file = File.open(@filepath, "rb")
    file.read
  end

  def clean_contents
    REMOVE.each do |remove|
      @contents.sub!(remove, '')
    end
    @contents
  end
end


class NullConfig
  attr_reader :roles
end