require 'yaml'
require_relative '../cap_expect'

module CapExpect
  class Settings
    FILE = '.capx.yaml'.freeze
    FILE_TEMPLATE = File.expand_path('.capx.init.yaml', CapExpect.root).freeze
    PROJECT_PATH = File.expand_path(FILE).freeze
    HOME_PATH = File.join(ENV['HOME'], FILE).freeze

    def load
      @settings ||= begin
        capex = load_settings(FILE) || load_settings(HOME_PATH)
        capex || {}
      end
    end

    private

    def load_settings(path)
      return unless File.exist? path
      ::YAML.load_file(path)
    end

  end
end