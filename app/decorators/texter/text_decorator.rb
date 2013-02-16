# encoding: UTF-8
require 'draper'

module Texter
  class TextDecorator < Draper::Decorator
    decorates 'Texter::Text'
    delegate_all

    def body
      return textile unless can_edit?

      h.content_tag(content_tag, textile, {
        :data => {
          :url => h.texter.edit_text_path(path, :js, :text => {
            :tag_type => tag_type
          })
        },
        :class => "js-edit #{path_for_class}"
      })
    end

    def path_for_class
      path.gsub(/\./, '-')
    end

    private

    def content_tag
      {:block => :div, :inline => :span}[tag_type.to_sym]
    end

    def textile
      body = get_body
      body = "Редактировать" if can_edit? && body.blank?
      h.send("textile_#{tag_type}", body)
    end

    def can_edit?
      h.text_can_be_edited?(model)
    end
  end
end
