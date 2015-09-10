class CapExpect::Commands < Thor; end

module CapExpect
  class Commands::Init

    FILE_PATH = File.expand_path CapExpect::Settings::FILE
    EXISTS = "#{FILE_PATH} already exists".freeze
    CREATED = "Created #{FILE_PATH}".freeze

    def initialize
      return puts EXISTS if File.exist? CapExpect::Settings::FILE
      create
      puts CREATED
    end

    private

    def create
      FileUtils.cp(CapExpect::Settings::FILE_TEMPLATE, CapExpect::Settings::FILE)
    end

  end
end