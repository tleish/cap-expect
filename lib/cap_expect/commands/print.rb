require_relative '../capfiles'
require 'forwardable'

class CapExpect::Commands < Thor; end

module CapExpect
  # helper to print expect script to terminal
  class Commands::Print

    extend Forwardable
    def_delegators :@cap_expect, :print

    def initialize(*capfile)
      @capfiles = CapExpect::Capfiles.new(*capfile)
      @cap_expect = CapExpect::Expect.new(variables, expect)
    end

    private

    def variables
      ConfigurationExpect.new(@capfiles).variables
    end

    def expect
      option = CapExpect::Menu.new('Which expect? ', expects).present
      option.choice_object[:expect]
    end

    def expects
      CapExpect.settings.each_with_object({}) do |(method, setting), hash|
        hash[method] = setting
      end
    end

  end
end