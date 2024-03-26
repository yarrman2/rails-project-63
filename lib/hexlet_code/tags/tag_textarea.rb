# frozen_string_literal: true

module HexletCode
  class TagTextarea < BaseInput
    def build
      build_with_label(create_textarea)
    end

    def prepare_options
      {
        cols: 20,
        rows: 40
      }.merge(@options)
    end

    def create_textarea
      HexletCode::Tag.build('textarea', prepare_options) { @field.value }
    end
  end
end
