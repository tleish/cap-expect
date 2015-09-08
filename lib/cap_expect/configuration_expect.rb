require 'cap_expect/capfiles'
require 'cap_expect/configuration'
require 'cap_expect/menu'

module CapExpect
  # Context class combining CapExpect and Configuration
  class ConfigurationExpect
    def initialize(capfiles, roles=nil)
      @capfiles = capfiles
      @roles = roles
    end

    def variables
      variables = configuration.choice_object.variables.dup
      variables[:host] = configuration.choice
      extract_ports(variables).merge(variables)
    end

    private

    def config_path
      capfile = CapExpect::Menu.new('Which capfile? ', @capfiles.index_by(&:path) ).present
      capfile.choice_object.config_path
    end

    def configuration
      @configuration ||= begin
        configurations = CapExpect::Configuration.new.load(config_path)
        CapExpect::Menu.new('Which host? ', configurations.index_by_host(@roles) ).present
      end
    end

    def has_port?(value)
      return unless value.is_a? String
      _, port = value.split(':')
      port.to_i > 0
    end

    def extract_ports(variables)
      hash = {}
      variables.each do |key, value|
        next unless has_port?(value)
        hash["#{key}_root".to_sym], hash["#{key}_port".to_sym] = value.split(':')
      end
      hash
    end

  end
end
