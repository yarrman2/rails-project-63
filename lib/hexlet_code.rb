# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Simplest Form
module HexletCode
  autoload(:Tag, './lib/hexlet_code/tag.rb')
  autoload(:Form, './lib/hexlet_code/form.rb')

  @submit_tag = :submit
  def self.form_for(entity, options = {}, &block)
    options.transform_keys!(url: :action)
    form_options = { action: '#', method: 'post' }.merge(options)

    return Tag.build('form', form_options) if block.nil?

    f = Form.new
    block.call(f)

    Tag.build('form', form_options) do
      form_inputs f.fields, entity
    end
  end

  def self.form_inputs(fields, entity)
    (fields.map do |field|
       field_name = field.fetch(:field_name, nil)
       value = nil
       value = entity.public_send(field_name) unless field[:as] == @submit_tag
       opts = {
         name: field_name
       }

       create_tag field_name, value, opts, field
     end).join
  end

  def self.create_input(opts = {}, label = '')
    input = Tag.build('input', opts)
    name = opts.fetch(:name, '')
    label = Tag.build('label', { for: name.to_s }) { name.capitalize } unless name.empty?

    label + input
  end

  def self.create_textarea(opts, field, value)
    opts[:cols] = 20
    opts[:rows] = 40
    name = opts.fetch(:name, '')
    label = Tag.build('label', { for: name.to_s }) { name.capitalize } unless name.empty?
    textarea = Tag.build('textarea', opts.merge(field[:options])) { value }
    label + textarea
  end

  def self.create_tag(field_name, value, opts, field)
    case field[:as]
    when :text
      create_textarea opts, field, value
    when :submit
      Tag.build('submit', { value: field_name })
    else
      opts[:type] = 'text'
      opts[:value] = value
      create_input(opts.merge(field[:options]))
    end
  end
end
