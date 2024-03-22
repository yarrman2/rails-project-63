# frozen_string_literal: true

# HexletCode
module HexletCode
  autoload(:TagInput, './lib/hexlet_code/tags/tag_input')
  autoload(:TagText, './lib/hexlet_code/tags/tag_textarea')
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

    def create_tag(options)
      tag_type = options[:config][:as].to_s.capitalize
      tag_name = "Tag#{tag_type}"
      tag_class = HexletCode.const_get(tag_name)
      tag_class.new(options).build
    end
  end
end
