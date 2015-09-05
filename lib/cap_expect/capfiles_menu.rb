# Get config path from capfile
module CapExpect
  class CapfilesMenu

    PROMPT = 'Which Capfile? (default 1)'
    attr_reader :choices
    def initialize(capfiles)
      @choices = capfiles.index_by(&:path)
    end

  end
end

