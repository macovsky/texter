module Texter
  class Formatter
    attr_reader :body

    def initialize(body)
      @body = body
    end

    # @return [String, NilClass]
    def inline
      raise NotImplementedError
    end

    # @return [String, NilClass]
    def block
      raise NotImplementedError
    end
  end
end
