require_relative '../capfiles'

class CapExpect::Commands < Thor; end

module CapExpect
  # list the capfiles that are available
  class Commands::List
    def initialize(*capfile)
      @capfiles = CapExpect::Capfiles.new(capfile)
    end

    def print
      puts @capfiles.paths.to_yaml
    end
  end
end