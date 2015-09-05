require_relative 'expect'

module CapExpect
  class Ssh
    def initialize(server)
      @server = server
    end

    def run
      Expect.new(start_ssh, 'interact', 'exit 1').run
    end

    private

    def start_ssh
      %Q[spawn ssh -A #{@server.config.gateway.split(':').first}

        expect "Last login:"
        send "ssh #{@server.config.user}@#{@server.host}\r"

        while 1 {
          expect {
            "Are you sure you want to continue connecting (yes/no)?" {
              send "yes\r"
            }

            "Last login:" {
              send {alias l="ls -l"\r}
              send "cd #{@server.config.deploy_to}/current\r"
              break
            }
          }
        }
       ]
    end

  end
end