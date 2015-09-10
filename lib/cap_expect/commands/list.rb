require_relative '../capfiles'

class CapExpect::Commands < Thor; end

module CapExpect
  class Commands::List
    def initialize(*capfile)
      @capfiles = CapExpect::Capfiles.new(capfile)
    end

    def print
      puts @capfiles.paths.to_yaml
    end
  end
end