module Texter
  module TextsHelper
    def inline(path, options = {})
      display_text(path, :inline, options)
    end

    def block(path, options = {})
      display_text(path, :block, options)
    end

    def display_text(path, tag_type, options = {})
      text = Texter::BuildText.call(path, tag_type, @virtual_path, options)
      presenter = Texter::TextPresenter.new(text, self, options)
      presenter.body
    end
  end
end
