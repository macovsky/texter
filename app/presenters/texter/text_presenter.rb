# encoding: UTF-8
module Texter
  class TextPresenter
    attr_reader :text, :h

    delegate :get_body, :path, to: :text

    def initialize(text, h)
      @text = text
      @h    = h
    end

    def body(tag_type, options = {})
      body = formatted(tag_type, options).html_safe

      return body unless can_be_edited?

      h.content_tag(content_tag_name(tag_type), body, {
        data: {
          url: h.texter.edit_text_path(path, :js),
          locale: options[:locale] || I18n.locale,
          tag_type: tag_type,
          formatter: formatter_name(options)
        },
        class: "js-edit #{path_for_class}"
      })
    end

    def path_for_class
      path.gsub(/\./, '-')
    end

    def can_be_edited?
      can = Texter.configuration.can_be_edited

      case can
        when Symbol
          h.send(can)
        when Proc
          can.call(text, h)
        else
          can
      end
    end

    private

    def formatter_name(options)
      options[:formatter] || Texter.configuration.formatter
    end

    def formatter(options)
      Texter.find_formatter(formatter_name(options))
    end

    def content_tag_name(tag_type)
      {
        block: :div,
        inline: :span
      }.fetch(tag_type.to_sym)
    end

    def formatted(tag_type, options)
      body = get_body
      body = Texter.t("edit", options.slice(:locale).merge(default: 'Редактировать')) if can_be_edited? && body.blank?
      formatter(options).new(body).send(tag_type)
    end
  end
end
