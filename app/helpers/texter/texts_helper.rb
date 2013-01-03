module Texter
  module TextsHelper
    def inline(path)
      display_text(path, :inline)
    end

    def block(path)
      display_text(path, :block)
    end

    def display_text(path, tag_type)
      text = Texter::TextFactory.new(path, tag_type, @virtual_path).build
      text.body
    end

    def text_can_be_edited?(text)
      moderator_signed_in?
    end

    def textile(string, *rules)
      return nil if string.blank?

      textilize = ::RedCloth.new(string, rules)
      textilize.to_html(:block_textile_prefix, :block_textile_lists, :inline_textile_link).html_safe

      # refs_textile::          Textile references (i.e. [hobix]http://hobix.com/)
      # block_textile_table::   Textile table block structures
      # block_textile_lists::   Textile list structures
      # block_textile_prefix::  Textile blocks with prefixes (i.e. bq., h2., etc.)
      # inline_textile_image::  Textile inline images
      # inline_textile_link::   Textile inline links
      # inline_textile_span::   Textile inline spans
      # inline_textile_glyphs:: Textile entities (such as em-dashes and smart quotes)
    end

    def textile_block(string)
      textile(string)
    end

    def textile_inline(string)
      textile(string, :lite_mode)
    end
  end
end
