# frozen_string_literal: true

# HexletCode
module HexletCode
  # internal class for the form creating
  class Form
    attr_reader :fields

    def initialize
      @fields = []
    end

    def input(field_name, options = {})
      as = options.delete(:as) || :input

      field({
              options: { type: 'text', name: field_name.to_s }.merge(options),
              config: {
                entity_field: true,
                row_name: field_name,
                need_label: true,
                as:
              }
            })
    end

    def submit(value = nil, options = {})
      as = options.delete(:as) || :input

      value ||= 'Save'
      field({
              options: { type: 'submit', value: value.capitalize }.merge(options),
              config: {
                as:,
                entity_field: false,
                need_label: false
              }
            })
    end

    private

    def field(opts)
      @fields << opts
    end
  end
end
