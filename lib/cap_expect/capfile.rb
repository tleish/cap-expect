module CapExpect
  # Get config path from capfile
  class Capfile
    CONFIG_FILE_PATH = 'config/deploy'
    CONFIG_FILE_PATH_REGEX = /config\/deploy[\w\- ]*/
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def config_path
      @config_path ||= begin
        config_path_from_capfile || default_config_path || ''
      end
    end

    private

    def config_path_from_capfile
      return unless File.exist? @path
      file = File.open(@path, 'rb').read
               .scan(CONFIG_FILE_PATH_REGEX).first
      File.join(file + '.rb')
    end

    def default_config_path
      path = File.join(CONFIG_FILE_PATH, base_file)
      return unless File.exist? path
      path
    end

    def base_file
      File.basename(@path, '.rb') + '.rb'
    end

  end
end
