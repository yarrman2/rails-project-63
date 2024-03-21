# frozen_string_literal: true

# Semplest From extends
module HexletCode
  # Tag
  module Tag
    def self.build(tag_name, options = {}, &block)
      single_tags = %w[br hr input img]

      attributes = options.map { |k, v| %(#{k}="#{v}") }.join(' ')
      attributes = " #{attributes}" unless attributes.empty?

      open_tag = "<#{tag_name}#{attributes}>"
      content = block.nil? ? '' : block.call
      close_tag = "</#{tag_name}>"

      return open_tag if single_tags.include? tag_name

      "#{open_tag}#{content}#{close_tag}"
    end
  end
end
