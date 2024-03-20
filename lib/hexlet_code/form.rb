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
      as_type = options.fetch(:as, nil)
      options.delete(:as)
      @fields << {
        field_name:,
        as: as_type,
        options:
      }
    end

    def submit(title = '', _options = {})
      input(title, { as: :submit })
    end
  end
end
