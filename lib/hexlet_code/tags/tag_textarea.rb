# frozen_string_literal: true

# HexletCode
module HexletCode
  # Tag Textarea
  class TagText
    def initialize(options)
      @config = options[:config]
      @name, @value, @options = prepare_text(options[:options])
    end

    def build
      create_label + create_text
    end

    def prepare_text(options)
      options[:cols] = 20
      options[:rows] = 40

      name = options.fetch(:name, '')
      value = options.delete(:value) || ''
      options.delete(:type)
      [name, value, options]
    end

    def create_label
      return '' unless @config[:need_label]

      @name ||= ''
      HexletCode::Tag.build('label', { for: @name.to_s }) { @name.capitalize }
    end

    def create_text
      HexletCode::Tag.build('textarea', @options) { @value }
    end
  end
end
