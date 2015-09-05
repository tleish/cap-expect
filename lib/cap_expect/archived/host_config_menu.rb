# require_relative '../menu'
#
# class CapExpect::Capfiles; end # fix for uninitialized constant CapExpect::Capfiles
#
# # Get config path from capfile
# module CapExpect
#   class Capfiles::Menu < CapExpect::Menu
#
#     ROLE_HOST_ORDER = [:app, :web, :db]
#
#     attr_reader :host, :configuration
#
#     def initialize(configurations)
#       @configurations = configurations
#       super('Select Capfile')
#     end
#
#     def option
#       configuration_by menu
#     end
#
#     private
#
#     def menu
#       choose do |menu|
#         menu.prompt = 'Which host? (default: 1)'
#         menu.choices(*hosts) do |chosen|
#           return chosen
#         end
#       end
#     end
#
#     def hosts
#       @hosts ||= @configurations.map do |config|
#         config.hosts(ROLE_HOST_ORDER)
#       end.flatten
#     end
#
#     def configuration_by(host_idx = nil)
#       @host = hosts[host_idx.to_i]
#       @configuration = @configurations.detect do |config|
#         config.hosts.include? host
#       end
#     end
#
#   end
# end
#
