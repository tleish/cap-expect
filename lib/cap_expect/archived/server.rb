require 'thor'
require 'highline/import'
require_relative 'dir_configs'
require_relative 'printers/details'

module CapExpect
  class Server
    BASE_DIR = Dir.pwd

    attr_reader :host, :config

    def initialize(config_file=nil)
      @config_file = config_file
      build
    end

    private

    def build
      servers = CapExpect::Printers::Details.new(dir_configs.configs).by_hosts
      @host = choose_server(servers.keys).to_s
      config = dir_configs.find_by_host(@host)
      raise Thor::Error, 'Invalid config file or config file is missing gateway' unless config
      @config = config.attributes
    end

    def dir_configs
      @dir_configs ||= CapExpect::DirConfigs.new(BASE_DIR, @config_file)
      raise Thor::Error, "Could not find 'config/#{@config_file}.rb'" if @dir_configs.configs.empty?
      @dir_configs
    end

    def choose_server(servers)
      choose do |menu|
        menu.prompt = 'Which host?'
        menu.choices(*servers) do |chosen|
          return chosen
        end
      end
    end

  end
end