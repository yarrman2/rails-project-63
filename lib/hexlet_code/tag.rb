# frozen_string_literal: true

# Semplest From extends
module HexletCode
  # Tag
  module Tag
    @single_tags = %w[br hr input img]
    @tags = %w[p div label]
    @submit_tag = 'submit'

    def self.build(tag_name, options = {}, &block)
      return submit(options) if tag_name == @submit_tag

      attributes = options.map { |k, v| %(#{k}="#{v}") }.join(' ')
      attributes = " #{attributes}" unless attributes.empty?

      open_tag = "<#{tag_name}#{attributes}>"
      content = block.nil? ? '' : block.call
      close_tag = "</#{tag_name}>"

      return open_tag if @single_tags.include? tag_name

      "#{open_tag}#{content}#{close_tag}"
    end

    def self.submit(value = {})
      if value.nil?
        value_field = 'Save'
      elsif value.instance_of? String
        value_field = value
      else
        value_field = value.fetch(:value, nil)
        value_field = 'Save' if value_field.empty?
      end
      %(<input type="submit" value="#{value_field.capitalize}">)
    end
  end
end
