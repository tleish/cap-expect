# gem 'capistrano', '~> 3.4.0'
require 'net/ssh/proxy/command'
require 'sshkit'
require 'capistrano/configuration'

module CapExpect
  # Parse a capfile and return configuration variables
  class Configuration < ::Capistrano::Configuration

    NULL_CONFIG = %(set :application, 'missing'\nrole :none, '')
    VARIABLES_AND_ROLES_REGEX = /^\s*(?:set|role) (?:.+\n)+/m
    REQUIRES_REGEX = /^\s*require[^\n]+\n/m

    def load(config_path)
      @config_path = File.expand_path config_path
      set_capistrano_2_variables
      instance_eval(content)
      self
    end

    # order = [:app, :web, :db]
    def hosts(order = nil)
      order ||= roles.keys
      hosts = Array(order).flat_map do |type|
        roles.fetch(type, []).map(&:hostname).reject(&:empty?)
      end
      hosts.uniq
    end

    def roles
      @roles ||= begin
        uniq_roles = servers.map(&:roles).map(&:to_a).flatten.uniq
        uniq_roles.each_with_object({}) do |role, hash|
          hash[role] = servers.select{|server|server.roles.include? role} || []
        end
      end
    end

    def index_by_host(order = roles.keys)
      order ||= roles.keys
      hosts(order).each_with_object({}) do |host, hash|
        hash[host] = self
      end
    end

    def variables
      @variables ||= keys.each_with_object({}) do |key, hash|
        hash[key] = fetch(key)
      end
    end

    # Capistrano 2 backwards compatible role method
    def role(name, *args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      super(name.to_sym, args, options)
    end

    # Capistrano 2: handle interpolated variables
    def set_capistrano_2_variables
      %w{default_run_options ssh_options}.each { |var| set var.to_sym, {} if content.include?(var) }
    end

    # # Capistrano 2: handle old methods
    def method_missing(name, *args, &block)
      return nil unless args.length == 2
      fetch(*args, &block)
    end

    private

    def content
      @content ||= begin
        return NULL_CONFIG unless File.exist? @config_path
        File.open(@config_path, 'rb')
          .read
          .gsub(REQUIRES_REGEX, '') || ''
      end
    end


  end
end
