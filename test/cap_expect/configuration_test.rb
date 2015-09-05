require_relative '../test_helper'
require 'cap_expect/configuration'

describe CapExpect::Configuration do
  it "Can parse a capfile" do
    given_a_configuration 'config/deploy.rb'
    when_the_configuration_is_loaded
    then_know_the_configuration(
        application: 'my app',
        gateway: '1.2.3.4:22',
        branch: 'master',
        deploy_to: '/this/is/my/path',
        hosts: 6,
        app_hosts: 4
      )
    and_order_hosts
    and_ensure_hosts_are_uniq
  end

  it "Can parse older capistrano files with missing attributes" do
    given_a_configuration 'config/deploy-old.rb'
    when_the_configuration_is_loaded
    then_know_the_configuration(
        application: 'my app',
        gateway: nil,
        branch: nil,
        deploy_to: nil,
        hosts: 2,
        app_hosts: 1
      )
    and_order_hosts
    and_ensure_hosts_are_uniq
  end

  it "Can create a Null Capfile when none exists" do
    given_a_configuration 'does not exist'
    when_the_configuration_is_loaded
    then_know_the_configuration(
        application: 'missing',
        gateway: nil,
        branch: nil,
        deploy_to: nil,
        hosts: 0,
        app_hosts: 0
      )
  end

  private

  def given_a_configuration(filepath)
    ::Dir.chdir test_root_dir
    @config_path = filepath
  end

  def when_the_configuration_is_loaded
    @config = CapExpect::Configuration.new
    @config.load(@config_path)
  end

  def then_know_the_configuration(variables)
    @config.variables[:application].must_equal variables[:application]
    @config.variables[:gateway].must_equal variables[:gateway]
    @config.variables[:branch].must_equal variables[:branch]
    @config.variables[:deploy_to].must_equal variables[:deploy_to]
    @config.roles.must_be_instance_of Hash
    @config.hosts.length.must_equal variables[:hosts]
    @config.roles[:app].map(&:host).length.must_equal variables[:app_hosts]
  end

  def and_order_hosts
    @config.hosts([:app, :web, :db]).first.must_include 'app'
    @config.hosts(:web).first.must_include 'web'
  end

  def and_ensure_hosts_are_uniq
    @config.hosts.uniq.must_equal @config.hosts
  end

end