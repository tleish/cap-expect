module CapExpect
  # build an expect script for a remote shell
  class Expect::Console

    DEFAULT_HASH = {host: nil, gateway: nil, user: nil, deploy_to: nil }

    EXPECT = %(send "ruby script/rails console production %{flags}\r")

    def initialize(sandbox: true)
      @sandbox = sandbox
    end

    def expect
      EXPECT % expect_variables
    end

    private

    def expect_variables
      {flags: @sandbox ? '--sandbox' : ''}
    end

  end
end