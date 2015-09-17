require_relative 'capfile'

module CapExpect
  # Can get all capfile paths in a directory
  class Capfiles
    include Enumerable

    DEFAULT_PATTERN = 'capfile*'
    attr_reader :paths

    def initialize(paths)
      @paths = Array(paths).empty? ? ::Dir[DEFAULT_PATTERN] : Array(paths)
    end

    def each(&block)
      @paths.each do |path|
        block.call(Capfile.new path)
      end
    end

    def index_by
      if block_given?
        Hash[map { |elem| [yield(elem), elem] }]
      else
        to_enum(:index_by) { size if respond_to?(:size) }
      end
    end

  end
end
