require_relative '../test_helper'
require 'cap_expect/capfiles'

describe CapExpect::Capfiles do
  it "Can get all capfiles in a directory" do
    given_capfiles_in_a_directory
    when_capfiles_are_requested_without_a_pattern
    then_know_capfiles_in_directory_are 3
      and_list_each_capfile
      and_index_by_capfile
  end

  it "Can get capfiles from a pattern" do
    given_capfiles_in_a_directory
    when_capfiles_are_requested_with_a_pattern
    then_know_capfiles_in_directory_are 1
  end

  private

  def given_capfiles_in_a_directory
    ::Dir.chdir test_root_dir
  end

  def when_capfiles_are_requested_without_a_pattern
    @capfiles = CapExpect::Capfiles.new([]) #::Dir.glob 'capfile*', File::FNM_CASEFOLD
  end

  def when_capfiles_are_requested_with_a_pattern
    @capfiles = CapExpect::Capfiles.new @dir  ::Dir.glob 'capfile-*', File::FNM_CASEFOLD
  end

  def then_know_capfiles_in_directory_are(number)
    @capfiles.paths.length.must_equal number
  end

  def and_list_each_capfile
    @capfiles.respond_to? :each
    @capfiles.first.is_a? CapExpect::Capfile
  end

  def and_index_by_capfile
    @capfiles.index_by(&:path).keys.must_equal %w[Capfile capfile-old config/deploy/main.rb]
  end

end