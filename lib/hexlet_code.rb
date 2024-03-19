# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative "hexlet_code/tag"

# Simplest Form
module HexletCode
  autoload(:Tag, "./lib/hexlet_code/tag.rb")
  @submit_tag = :submit
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
       field_name = field.fetch(:field_name, nil)
       value = nil
       value = user.public_send(field_name) unless field[:as] == @submit_tag
       opts = {
         name: field_name
       }

       create_tag field_name, value, opts, field
     end).join("")
  end

  def self.create_input(opts = {}, label = "")
    input = Tag.build("input", opts)
    name = opts.fetch(:name, "")
    label = Tag.build("label", { for: name.to_s }) { name.capitalize } unless name.empty?

    label + input
  end

  def self.create_textarea(opts, field, value)
    opts[:cols] = 20
    opts[:rows] = 40
    name = opts.fetch(:name, "")
    label = Tag.build("label", { for: name.to_s }) { name.capitalize } unless name.empty?
    textarea = Tag.build("textarea", opts.merge(field[:options])) { value }
    label + textarea
  end

  def self.create_tag(field_name, value, opts, field)
    case field[:as]
    when :text
      create_textarea opts, field, value
    when :submit
      Tag.build("submit", { value: field_name })
    else
      opts[:type] = "text"
      opts[:value] = value
      create_input(opts.merge(field[:options]))
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

    def submit(title = "", _options = {})
      input(title, { as: :submit })
    end
  end
end
