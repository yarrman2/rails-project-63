# frozen_string_literal: true

require_relative "simplest_form/version"
require_relative "simplest_form/tag"

# Simplest Form
module SimplestForm
  autoload(:Tag, "./lib/simplest_form/tag.rb")

  def self.form_for(user, options = {})
    form_options = {
      action: '#',
      method: 'post'
    }

    form_options[:action] = options[:url]  if options.key?(:url)

    SimplestForm::Tag.build('form', form_options)
  end
end
