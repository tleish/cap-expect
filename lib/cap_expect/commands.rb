require 'rubygems'
require 'thor'
require 'cap_expect/settings'
require 'cap_expect/expect'
require 'cap_expect/menu'
require 'cap_expect/configuration_expect'
require 'cap_expect/capfiles_menu'


module CapExpect
  class Commands < Thor

    desc 'init'.freeze, "creates a #{CapExpect::Settings::FILE} file in the working directory".freeze
    def init
      return puts "#{CapExpect::Settings::FILE} already exists" if File.exist? CapExpect::Settings::FILE
      FileUtils.cp(CapExpect::Settings::FILE_TEMPLATE, CapExpect::Settings::FILE)
      puts "Created #{File.expand_path CapExpect::Settings::FILE}"
    end

    desc 'list'.freeze, 'list the capfiles in the current directory (short-cut alias: "l")'.freeze
    def list(*capfile)
      capfiles = CapExpect::Capfiles.new(capfile)
      puts capfiles.paths.to_yaml
    end

    desc 'variables [capfile]'.freeze, 'show the capfile variables (short-cut alias: "v")'.freeze
    def variables(*capfile)
      capfiles = CapExpect::Capfiles.new(capfile)
      puts ConfigurationExpect.new(capfiles).variables.to_yaml
    end

    desc 'print [capfile]'.freeze, 'show expect command output (short-cut alias: "p")'.freeze
    def print(*capfile)
      expects = CapExpect.settings.inject({}) { |hash, (method, setting)| hash[method] = setting; hash }
      option = CapExpect::Menu.new('Which expect? ', expects ).present
      capfiles = CapExpect::Capfiles.new(capfile)
      variables = ConfigurationExpect.new(capfiles).variables
      CapExpect::Expect.new(variables, option.choice_object[:expect]).print
    end

    # Build dynamic expect scripts
    CapExpect.settings.each do |method, settings|
      next unless settings.is_a? Hash
      desc "#{method} [capfile]".freeze, (settings[:desc]+ '(print outputs the script)').freeze
      define_method(method) do |*capfile|
        capfiles = CapExpect::Capfiles.new(capfile)
        variables = ConfigurationExpect.new(capfiles, settings[:roles]).variables
        CapExpect::Expect.new(variables, settings[:expect]).run
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
