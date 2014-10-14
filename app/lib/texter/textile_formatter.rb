module Texter
  class TextileFormatter < Formatter
    def inline
      textile [:lite_mode]
    end

    def block
      textile
    end

    protected

    def textile(restrictions = [])
      return if body.blank?
      textile = ::RedCloth.new(body, [*restrictions, :no_span_caps])
      textile.to_html
    end
  end
end
