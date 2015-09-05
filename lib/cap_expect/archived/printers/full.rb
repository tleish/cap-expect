require 'yaml'

module CapExpect
  module Printers

    class Full
      def initialize(configs)
        @configs = configs
      end

      def print
        puts @configs.to_yaml
      end
    end

  end
end