module Texter
  class SimpleFormatter < Formatter
    def inline
      body
    end

    def block
      ApplicationController.helpers.simple_format(body)
    end
  end
end
