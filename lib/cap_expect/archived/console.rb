require_relative 'ssh'

module CapExpect

  class Console < Ssh

    def run
      start_rails_console = 'send "ruby script/rails console production\r"'
      Expect.new(start_ssh, start_rails_console, 'interact', 'exit 1').run
    end

  end

end