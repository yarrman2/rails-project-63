# frozen_string_literal: true

# HexletCode
module HexletCode
  # render class
  class Renderer
    def initialize(form, entity, options)
      @form = form
      @entity = entity
      @options = options
    end

    def render
      options = @options.transform_keys(url: :action)

      form_options = { action: '#', method: 'post' }.merge(options)
      return HexletCode::Tag.build('form', form_options) if @form.fields.empty?

      HexletCode::Tag.build('form', form_options) do
        form_inputs @form.fields
      end
    end

    def form_inputs(fields)
      (fields.map do |field|
         config = field[:config]

         if config[:entity_field]
           row_name = config[:row_name]
           value = @entity.public_send(row_name)
           field[:options].merge!(value:)
         end

         create_tag field
       end).join
    end

    def create_input(options = {})
      config = options[:config]
      options = options[:options]
      need_label = config[:need_label]

      input = HexletCode::Tag.build('input', options)
      return input unless need_label

      name = options.fetch(:name, '')
      label = HexletCode::Tag.build('label', { for: name }) { name.capitalize }
      label + input
    end

    def prepare_text(options)
      options[:cols] = 20
      options[:rows] = 40

      name = options.fetch(:name, '')
      value = options.delete(:value) || ''
      options.delete(:type)
      [name, value, options]
    end

    def create_text(options)
      config = options[:config]
      need_label = config[:need_label]
      name, value, options = prepare_text(options[:options])

      textarea = HexletCode::Tag.build('textarea', options) { value }
      return textarea unless need_label

      label = HexletCode::Tag.build('label', { for: name.to_s }) { name.capitalize } unless name.empty?
      label + textarea
    end

    def create_tag(options)
      tag_name = options[:config][:as].to_s
      send("create_#{tag_name}", options)
    end
  end
end
