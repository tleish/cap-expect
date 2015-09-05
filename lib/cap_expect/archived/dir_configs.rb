require_relative 'file_config'

module CapExpect

  class DirConfigs
    def initialize(base_dir, basename=nil)
      @base_dir = base_dir
      @basename = basename
    end

    def configs
      @configs ||= ::Dir[File.join(@base_dir, "/config/deploy-*.rb")].map do |path|
        next unless is_basename?(path)
        FileConfig.new(path) || NullConfig.new
      end.compact
    end

    def find_by_host(server)
      configs.detect do |config|
        next unless config.attributes && config.attributes.respond_to?(:gateway)
        servers = config.attributes.roles.map{|_, role|role.map(&:host)}.flatten
        servers.include? server.to_s
      end
    end

    private

    def is_basename?(filepath)
      return true if @basename.nil?
      basename = File.basename(filepath, '.*')
      @basename == basename
    end

  end

end
