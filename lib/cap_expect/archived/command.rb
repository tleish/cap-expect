# require 'rubygems'
# require 'thor'
# require 'cap_expect/server'
# require 'cap_expect/console'
#
# module CapExpect
#   class Command < Thor
#
#     BASE_DIR = Dir.pwd
#
#     def self.capfiles
#       ::Dir[File.join(Dir.pwd, "capfile*")].map do |capfile|
#         File.basename(capfile)
#       end
#     end
#
#     desc 'list [capfile]', 'list the server environments from capfile (short-cut alias: "l")'
#     def list(capfile = nil)
#       config_file = config_path_from(capfile)
#       configs = CapExpect::DirConfigs.new(BASE_DIR, config_file).configs
#       puts CapExpect::Printers::Details.new(configs).to_yaml
#     end
#
#     desc 'ssh [capfile]', 'ssh to server from capfile(s)'
#     def ssh(capfile = nil)
#       run(CapExpect::Ssh, capfile)
#     end
#
#     desc 'console [capfile]', 'ssh to server from capfile (short-cut alias: "c")'
#     def console(capfile = nil)
#       run(CapExpect::Console, capfile)
#     end
#
#     # hide warnings of no description for aliased commands
#     no_commands do
#       alias_method :l, :list
#       alias_method :c, :console
#     end
#
#     private
#
#     def run(run_class, capfile=nil)
#       begin
#         config_file = config_path_from(capfile)
#         server = CapExpect::Server.new(config_file)
#         run_class.new(server).run
#       rescue SystemExit, Interrupt
#         # Handle Ctrl+C
#       rescue Exception => e
#         raise
#       end
#     end
#
#     def config_path_from(capfile)
#       return unless capfile
#       capfile.sub('capfile', 'deploy')
#     end
#
#
#   end
# end
