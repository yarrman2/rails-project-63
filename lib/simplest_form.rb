# frozen_string_literal: true

require_relative "simplest_form/version"
require_relative "simplest_form/tag"

# Simplest Form
module SimplestForm
  autoload(:Tag, "./lib/simplest_form/tag.rb")

  def self.form_for(user, options = {}, &block)
    form_options = { action: "#", method: "post" }

    form_options[:action] = options[:url] if options.key?(:url)

    return Tag.build("form", form_options) if block.nil?

    f = Form.new
    block.call(f)

    Tag.build("form", form_options) do
      form_inputs f.fields, user
    end
  end

  def self.form_inputs(fields, user)
    (fields.map do |field|
       field_name = field[:field_name]
       value = user.public_send(field_name)
       opts = {
         name: field_name
       }

       create_tag field_name, value, opts, field
     end).join("")
  end

  def self.create_tag(_field_name, value, opts, field)
    case field[:as]
    when :text
      opts[:cols] = 20
      opts[:rows] = 40

      Tag.build("textarea", opts.merge(field[:options])) { value }
    else
      opts[:type] = "text"
      opts[:value] = value
      Tag.build("input", opts.merge(field[:options]))
    end
  end

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
        field_name: field_name,
        as: as_type,
        options: options
      }
    end
  end
end
