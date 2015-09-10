require 'rubygems'
require 'thor'
require 'cap_expect/settings'
require 'cap_expect/expect'
require 'cap_expect/menu'
require 'cap_expect/configuration_expect'
require 'cap_expect/capfiles_menu'

Dir[File.expand_path('../commands/*.rb', __FILE__) ].each {|file| require file }

module CapExpect
  class Commands < Thor

    desc 'init'.freeze, "creates a #{CapExpect::Settings::FILE} file in the working directory".freeze
    def init
      CapExpect::Commands::Init.new
    end

    desc 'list'.freeze, 'list the capfiles in the current directory (short-cut alias: "l")'.freeze
    def list(*capfile)
      CapExpect::Commands::List.new(*capfile).print
    end

    desc 'variables [capfile]'.freeze, 'show the capfile variables (short-cut alias: "v")'.freeze
    def variables(*capfile)
      CapExpect::Commands::Variables.new(*capfile).print
    end

    desc 'print [capfile]'.freeze, 'show expect command output (short-cut alias: "p")'.freeze
    def print(*capfile)
      CapExpect::Commands::Print.new(*capfile).print
    end

    # Build dynamic expect scripts
    CapExpect.settings.each do |method, setting|
      desc "#{method} [capfile]".freeze, (setting[:desc]+ '(print outputs the script)').freeze
      define_method(method) do |*capfile|
        CapExpect::Commands::Custom.new(setting, *capfile).run
      end
    end

    # hide warnings of no description for aliased commands
    no_commands do
      alias_method :l, :list
      alias_method :v, :variables
      alias_method :p, :print
    end


  end
end
