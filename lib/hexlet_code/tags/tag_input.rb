# frozen_string_literal: true

# HexletCode
module HexletCode
  # TagInput
  class TagInput
    def initialize(options)
      @config = options[:config]
      @options = options[:options]
    end

    def build
      create_label + create_input
    end

    def create_label
      return '' unless @config[:need_label]

      name = @options.fetch(:name, '')
      HexletCode::Tag.build('label', { for: name }) { name.capitalize }
    end

    def create_input
      HexletCode::Tag.build('input', @options)
    end
  end
end
