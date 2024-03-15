# frozen_string_literal: true

require "active_support/inflector"
require_relative "simplest_form/version"
require_relative "simplest_form/tag"

# Simplest Form
module SimplestForm
  autoload(:Tag, "./lib/simplest_form/tag.rb")

  def self.form_for(user, options = {}, &block)
    form_options = {
      action: "#",
      method: "post"
    }

    form_options[:action] = options[:url] if options.key?(:url)

    return Tag.build("form", form_options) if block.nil?

    f = Form.new
    block.call(f)

    fields = f.fields

    Tag.build("form", form_options) do
      (fields.map do |field|
        field_name = field[:field_name]
        value = user.public_send(field_name)
        opts = {
          name: field_name
        }

        case field[:options].fetch(:as, nil)
        when :text
          opts[:cols] = 20
          opts[:rows] = 40
          Tag.build("textarea", opts) { value }
        else
          opts[:type] = "text"
          opts[:value] = value
          Tag.build("input", opts)
        end
      end).join("")
    end
  end

  class Form
    attr_reader :fields

    def initialize
      @fields = []
    end

    def input(field_name, options = {})
      @fields << {
        field_name: field_name,
        options: options
      }
    end
  end
end

User1 = Struct.new(:name, :job, :gender, keyword_init: true)
user = User1.new name: "rob", job: "hexlet", gender: "m"

form = SimplestForm.form_for user, url: "/users" do |f|
  f.input :name, class: "user-input"
  f.input :job, as: :text, rows: 50, cols: 50
end

p form
