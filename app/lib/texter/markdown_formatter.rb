require 'rdiscount'

module Texter
  class MarkdownFormatter < Formatter
    # :smart - Enable SmartyPants processing.
    # :filter_styles - Do not output <style> tags.
    # :filter_html - Do not output any raw HTML tags included in the source text.
    # :fold_lines - RedCloth compatible line folding (not used).
    # :footnotes - PHP markdown extra-style footnotes.
    # :generate_toc - Enable Table Of Contents generation
    # :no_image - Do not output any <img> tags.
    # :no_links - Do not output any <a> tags.
    # :no_tables - Do not output any tables.
    # :strict - Disable superscript and relaxed emphasis processing.
    # :autolink - Greedily urlify links.
    # :safelink - Do not make links for unknown URL types.
    # :no_pseudo_protocols - Do not process pseudo-protocols.
    cattr_accessor :extensions
    self.extensions = []

    # extracts html from the first paragraph or header
    def inline
      block.match(%r{<[hp]\d?>(.*?)</[hp]\d?>}).try(:[], 1)
    end

    def block
      return nil if body.blank?

      markdown = ::RDiscount.new(body, *options[:extensions])
      markdown.to_html
    end

    protected

    def reverse_merge_defaults
      options.assert_valid_keys(:extensions)
      options.reverse_merge!(:extensions => extensions)
    end
  end
end

