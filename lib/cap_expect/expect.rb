module CapExpect
  class Expect

    ESCAPE_SINGLE_QUOTES =  %('"'"').freeze

    def initialize(variables, script)
      @variables = variables
      @script = script
    end

    def run
      expect_script_escaped = expect_script.gsub("'".freeze, ESCAPE_SINGLE_QUOTES)
      exec %Q(expect -c '#{ expect_script_escaped }')
    end

    def print
      puts '#!/usr/bin/env expect'.freeze
      puts expect_script
      puts ''
    end

    private

    def expect_script
      @script % @variables
    end
  end

end