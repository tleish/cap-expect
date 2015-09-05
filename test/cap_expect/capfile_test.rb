require_relative '../test_helper'
require 'cap_expect/capfile'

describe CapExpect::Capfile do
  it "Can get config path from capfile" do
    given_a_capfile_exists_in_a_directory
    when_capfile_requested_is 'capfile'
    then_know_configuration_path_is 'config/deploy.rb'
  end

  it "Return empty config path invalid capfile" do
    given_a_capfile_exists_in_a_directory
    when_capfile_requested_is 'na'
    then_know_configuration_path_is ''
  end

  private

  def given_a_capfile_exists_in_a_directory
    ::Dir.chdir test_root_dir
  end

  def when_capfile_requested_is(path)
    @capfile = CapExpect::Capfile.new(path)
  end


  def then_know_configuration_path_is (path)
    @capfile.config_path.must_equal path
  end

end