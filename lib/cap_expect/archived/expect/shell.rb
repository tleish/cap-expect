require 'thor'

module CapExpect
  # build an expect script for a remote shell
  class Expect::Shell

    CAPEX_FILE = '.capex.yaml'

    def initialize(config)
      @config = config
    end

    def expect
      raise Thor::Error, "No .capex script defined" if capex.nil?
      begin
        capex % @config
      rescue KeyError => e
        raise Thor::Error, "#{e.message} in the capex script"
      end
    end

    private

    def capex
      @capex ||= begin
        project = File.expand_path(CAPEX_FILE)
        home = File.join(ENV['HOME'], CAPEX_FILE)
        read_capex(project) || read_capex(home)
      end
    end

    def read_capex(path)
      return unless File.exist? path
      File.open(path, 'rb').read
    end

  end
end