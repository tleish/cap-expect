require_relative '../capfiles'
require 'forwardable'

class CapExpect::Commands < Thor; end

module CapExpect
  # using settings, creates custom expect scripts
  class Commands::Custom

    extend Forwardable
    def_delegators :@cap_expect, :run

    def initialize(setting, *capfile)
      @setting = setting
      @capfiles = CapExpect::Capfiles.new(capfile)
      @cap_expect = CapExpect::Expect.new(variables, setting[:expect])
    end

    private

    def variables
      ConfigurationExpect.new(@capfiles, @setting[:roles]).variables
    end
  end
end