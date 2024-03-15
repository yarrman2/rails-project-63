# frozen_string_literal: true

# Semplest From extends
module SimplestForm
  # Tag
  module Tag
    @single_tags = %w[br hr input img]
    @tags = %w[p div label]

    def self.build(tag_name, options = {}, &block)
      attributes = options.map { |k, v| %(#{k}="#{v}") }.join(" ")
      attributes = " #{attributes}" unless attributes.empty?

      open_tag = "<#{tag_name}#{attributes}>"
      content = block.nil? ? "" : block.call
      close_tag = "</#{tag_name}>"

      return open_tag if @single_tags.include? tag_name

      open_tag + content + close_tag
    end
  end
end
