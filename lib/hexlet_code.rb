# frozen_string_literal: true

require_relative 'hexlet_code/version'

module HexletCode
  autoload(:Tag, 'hexlet_code/tag')
  autoload(:Form, 'hexlet_code/form/form')
  autoload(:Renderer, 'hexlet_code/renderer')

  def self.form_for(entity, options = {}, &block)
    form = HexletCode::Form.new
    block.call(form) if block_given?

    HexletCode::Renderer.new(form, entity, options).render
  end
end
