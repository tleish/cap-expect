require_relative '../test_helper'
require 'cap_expect/capfiles'
require 'cap_expect/menu'

describe CapExpect::Menu do

  PROMPT = 'Which Capfile? (default 1)'

  it "Can display menu for capfiles in a directory" do
    given_capfiles_in_a_directory
    when_capfiles_are_requested
    then_display_capfiles_menu
    and_default_to_the_first_host
  end

  private

  def given_capfiles_in_a_directory
    ::Dir.chdir test_root_dir
  end

  def when_capfiles_are_requested
    capfiles = CapExpect::Capfiles.new ['Capfile', 'capfile-old']
    @selector = CapExpect::Menu.new(PROMPT, capfiles.index_by(&:path))
  end

  def then_display_capfiles_menu
    @selector.respond_to?(:present).must_equal true
  end

  def and_default_to_the_first_host
    @selector.send(:menu_choices).must_equal ['Capfile', 'capfile-old']
  end

end