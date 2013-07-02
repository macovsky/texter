module Texter
  class Formatter
    attr_reader :body, :options

    def initialize(body, options = {})
      @body = body
      @options = options.dup
      reverse_merge_defaults
    end

    # @return [String, NilClass]
    def inline
      raise NotImplementedError
    end

    # @return [String, NilClass]
    def block
      raise NotImplementedError
    end

    protected

    def reverse_merge_defaults
    end
  end
end
