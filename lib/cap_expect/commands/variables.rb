require_relative '../capfiles'
require_relative '../configuration_expect'

class CapExpect::Commands < Thor; end

module CapExpect
  class Commands::Variables
    def initialize(*capfile)
      @capfiles = CapExpect::Capfiles.new(capfile)
    end

    def print
      puts ConfigurationExpect.new(@capfiles).variables.to_yaml
    end
  end
end
