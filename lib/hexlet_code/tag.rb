# frozen_string_literal: true

module HexletCode
  module Tag
    SINGLE_TAGS = %w[br hr input img].freeze
    OPTIONS_ORDER = %i[id type class name value].freeze

    def self.sorted_options(options)
      sorted = Hash[*OPTIONS_ORDER.collect { |key| [key, nil] }.flatten]
      sorted.merge(options).reject { |_, val| val.nil? }
    end

    def self.create_open_tag(tag_name, attributes)
      "<#{tag_name}#{attributes}>"
    end

    def self.create_close_tag_tag(tag_name)
      "</#{tag_name}>"
    end

    def self.create_tag(open_tag, content, close_tag)
      "#{open_tag}#{content}#{close_tag}"
    end

    def self.build(tag_name, options = {}, &block)
      attributes = sorted_options(options).map { |k, v| %( #{k}="#{v}") }.join

      open_tag = create_open_tag(tag_name, attributes)
      return open_tag if SINGLE_TAGS.include? tag_name

      content = (block.call if block_given?) || ''
      close_tag = create_close_tag_tag(tag_name)

      create_tag(open_tag, content, close_tag)
    end
  end
end
