# frozen_string_literal: true

module HexletCode
  class Field
    attr_reader :name, :as, :options, :type
    attr_accessor :value

    def initialize(options = {})
      @name = options[:name]
      @value = options[:value]
      @type = options[:type]
      @as = options[:as]
      @options = options[:options]
    end

    def to_hash
      @options.merge(
        name: @name,
        value: @value,
        type: @type
      ).compact
    end
  end
end
