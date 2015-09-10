require 'cap_expect/version'
require 'cap_expect/capfiles'
require 'cap_expect/configuration'

module CapExpect

  def self.settings
    @settings ||= begin
      CapExpect::Settings.new.load.
        select{|_, setting| setting.is_a? Hash}
    end
  end

  def self.root
    File.dirname __dir__
  end

end

require 'cap_expect/settings'
require 'cap_expect/commands'
