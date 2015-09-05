module CapExpect
  # Get config path from capfile
  class Capfile
    CONFIG_FILE_PATH_REGEX = /config\/deploy[\w\- ]*/
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def config_path
      @config_path ||= begin
        return '' unless File.exist? @path
        path = File.open(@path, 'rb').read
               .scan(CONFIG_FILE_PATH_REGEX).first
        File.join(path + '.rb')
      end
    end
  end
end
