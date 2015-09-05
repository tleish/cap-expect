module CapExpect
  class Commands::List
    def initialize

    end

    desc 'list [capfile]', 'list the server environments from capfile (short-cut alias: "l")'
    def run(capfile = nil)
      capfiles = CapExpect::Capfiles.new(capfile)
      puts CapExpect::Printers::Details.new(configs).to_yaml
    end
  end
end
