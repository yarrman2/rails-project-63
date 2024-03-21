# frozen_string_literal: true

# Semplest From extends
module HexletCode
  # Tag
  module Tag
    def self.build(tag_name, options = {}, &block)
      single_tags = %w[br hr input img]

      attributes = options.map { |k, v| %( #{k}="#{v}") }.join

      open_tag = "<#{tag_name}#{attributes}>"
      return open_tag if single_tags.include? tag_name

      content = block.call if block.given?

      close_tag = "</#{tag_name}>"

      "#{open_tag}#{content}#{close_tag}"
    end
  end
end
