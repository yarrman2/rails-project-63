# frozen_string_literal: true

module HexletCode
  TAG_WITHOUT_LABEL = %i[submit].freeze
  KEY_EXCEPT = {
    default: %i[as],
    text: %i[as value type]
  }.freeze
  CAPITALIZED_VALUE = %i[submit].freeze

  class BaseInput
    def initialize(field)
      @field = field
      @options = field.to_hash.except(
        *KEY_EXCEPT.fetch(
          @field.as,
          KEY_EXCEPT[:default]
        )
      )
      @has_label = TAG_WITHOUT_LABEL.none?(@field.type)
    end

    def build_with_label(input)
      return create_label + input if @has_label

      input
    end

    def build
      build_with_label(create_input)
    end

    def create_label
      name = @field.name
      HexletCode::Tag.build('label', { for: name }) { name.capitalize }
    end

    def create_input
      opts = @options
      opts[:value] = opts[:value].capitalize if CAPITALIZED_VALUE.include? @field.type
      HexletCode::Tag.build('input', opts)
    end
  end
end
