require 'highline/import'

module CapExpect
  # Base Menu Class
  class Menu

    attr_reader :choice, :choice_object

    def initialize(prompt, choices = {})
      @prompt = prompt
      @choices = choices
    end

    def present
      @choice = menu
      @choice_object = @choices[@choice]
      self
    end

    private

    def menu
      return menu_choices.first if only_one_choice?
      puts ''
      choose do |menu|
        menu.prompt = "\n#{@prompt} (default: 1. #{menu_choices.first})"
        menu.default = menu_choices.first
        menu.choices(*menu_choices) do |chosen|
          return chosen
        end
      end
    end

    def only_one_choice?
      menu_choices.length == 1
    end

    def menu_choices
      @menu_choices ||= @choices.keys.dup
    end

  end
end

