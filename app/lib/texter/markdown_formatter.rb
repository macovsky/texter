module Texter
  class MarkdownFormatter < Formatter
    # extracts html from the first paragraph or header
    def inline
      block.to_s.match(%r{<[hp]\d?>(.*?)</[hp]\d?>}).try(:[], 1)
    end

    def block
      return if body.blank?

      markdown = ::RDiscount.new(body)
      markdown.to_html
    end
  end
end

