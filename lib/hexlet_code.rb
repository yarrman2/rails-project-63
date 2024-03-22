# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Simplest Form
module HexletCode
  autoload(:Tag, './lib/hexlet_code/tag')
  autoload(:Form, './lib/hexlet_code/form')
  autoload(:Renderer, './lib/hexlet_code/render')

  def self.form_for(entity, options = {}, &block)
    form = Form.new
    block.call(form) if block_given?

    Renderer.new(form, entity, options).render
  end
end
