# frozen_string_literal: true

module HexletCode
  autoload(:Field, 'hexlet_code/form/field')
  class Form
    attr_reader :fields

    def initialize
      @fields = []
    end

    def add_field(options)
      @fields << Field.new(options)
    end

    def input(field_name, options = {})
      add_field({
                  name: field_name,
                  value: nil,
                  type: :text,
                  as: options.fetch(:as, nil),
                  options:
                })
    end

    def submit(value = 'Save', options = {})
      add_field({
                  name: nil,
                  value:,
                  type: :submit,
                  as: nil,
                  options:
                })
    end
  end
end
