# require_relative '../test_helper'
# require 'cap_expect/configuration_expect'
#
# describe CapExpect::ConfigurationExpect do
#   it "Can parse a capfile" do
#     given_a_capfile_exists_in_a_directory
#     when_the_configuration_is_loaded
#     then_know_the_configuration(
#       application: 'my app',
#       gateway: '1.2.3.4:22',
#       branch: 'master',
#       deploy_to: '/this/is/my/path',
#       hosts: 6,
#       app_hosts: 4
#     )
#     and_order_hosts
#     and_ensure_hosts_are_uniq
#   end
#
#
#   private
#
#   def given_a_capfile_exists_in_a_directory
#     ::Dir.chdir test_root_dir
#   end
#
#   def when_the_configuration_expect
#     ConfigurationExpect
#   end
#
# end