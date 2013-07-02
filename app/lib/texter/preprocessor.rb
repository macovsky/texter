module Texter
  class Preprocessor
    include CallableClass

    attr_reader :body

    # @param [String] body
    def initialize(body)
      @body = body
    end

    # @return [String, NilClass]
    def call
      raise NotImplementedError
    end
  end
end
