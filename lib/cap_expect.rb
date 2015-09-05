require 'cap_expect/version'
require 'cap_expect/capfiles'
require 'cap_expect/configuration'

module CapExpect

  # class << self
  #   attr_writer :settings
  # end

  def self.settings
    @settings ||= CapExpect::Settings.new.load
  end

  def self.root
    File.dirname __dir__
  end

end

require 'cap_expect/settings'
require 'cap_expect/commands'
