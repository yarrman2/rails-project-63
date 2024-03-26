# frozen_string_literal: true

module HexletCode
  autoload(:BaseInput, 'hexlet_code/tags/base_input')
  autoload(:TagText, 'hexlet_code/tags/tag_text')
  autoload(:TagSubmit, 'hexlet_code/tags/tag_submit')
  autoload(:TagTextarea, 'hexlet_code/tags/tag_textarea')

  TAG_TYPE_TRANSFORMATION = {
    text: :textarea
  }.freeze

  class Renderer
    def initialize(form, entity, options)
      @form = form
      @entity = entity
      @options = options
    end

    def render
      HexletCode::Tag.build('form', form_options) do
        form_inputs @form.fields
      end
    end

    def form_options
      options = @options.transform_keys(url: :action)
      { action: '#', method: 'post' }.merge(options)
    end

    def form_inputs(fields)
      (fields.map do |field|
         field.value = @entity.public_send(field.name) || '' unless field.type == :submit
         create_tag field
       end).join
    end

    def get_tagname(field)
      tag_type = TAG_TYPE_TRANSFORMATION.fetch(field.as, field.type)
      "Tag#{tag_type.to_s.capitalize}"
    end

    def create_tag(field)
      tag_class = HexletCode.const_get(get_tagname(field))
      tag_class.new(field).build
    end
  end
end
