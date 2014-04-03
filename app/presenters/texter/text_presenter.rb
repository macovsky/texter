# encoding: UTF-8
module Texter
  class TextPresenter
    attr_reader :text, :h, :options

    delegate :tag_type, :get_body, :path, to: :text

    def initialize(text, h, options = {})
      @text    = text
      @h       = h
      @options = options

      options.assert_valid_keys(:locale, :formatter, :formatter_options)
    end

    def body
      return formatted unless can_be_edited?

      h.content_tag(content_tag_name, formatted, {
        data: {
          url: h.texter.edit_text_path(path, :js, text: {
            tag_type: tag_type
          })
        },
        class: "js-edit #{path_for_class}"
      })
    end

    def path_for_class
      "texter-" + path.gsub(/\./, '-')
    end

    private

    def formatter
      Texter.find_formatter(options[:formatter] || Texter.formatter)
    end

    def content_tag_name
      {
        block: :div,
        inline: :span
      }.fetch(tag_type.to_sym)
    end

    def formatted
      body = get_body(locale_options)
      body = Texter.translate("edit", locale_options.merge(default: 'Редактировать')) if can_be_edited? && body.blank?
      formatter.new(body, options[:formatter_options] || {}).send(tag_type)
    end

    def can_be_edited?
      true
    end

    def locale_options
      options.slice(:locale)
    end
  end
end
