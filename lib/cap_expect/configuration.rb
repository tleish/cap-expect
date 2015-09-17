gem 'capistrano', '~> 2.14.2'
require 'capistrano/configuration'

module CapExpect
  # Parse a capfile and return configuration variables
  class Configuration < Capistrano::Configuration

    NULL_CONFIG = %(set :application, 'missing'\nrole :none, '')
    VARIABLES_AND_ROLES_REGEX = /^\s*(?:set|role) (?:.+\n)+/m
    REQUIRES_REGEX = /^\s*require[^\n]+\n/m

    def load(config_path)
      @config_path = File.expand_path config_path
      super(string: content)
      self
    end

    # order = [:app, :web, :db]
    def hosts(order = nil)
      order ||= roles.keys
      hosts = Array(order).flat_map do |type|
        roles[type].map(&:host).reject(&:empty?)
      end
      hosts.uniq
    end

    def index_by_host(order = roles.keys)
      hosts(order).each_with_object({}) do |host, hash|
        hash[host] = self
      end
    end

    private

    def content
      return NULL_CONFIG unless File.exist? @config_path
      File.open(@config_path, 'rb')
          .read
          .gsub(REQUIRES_REGEX, '')
    end

  end
end
