module Texter
  module TextsHelper
    def inline(path, options = {})
      text_presenter(path, options).body(:inline, options)
    end

    def block(path, options = {})
      text_presenter(path, options).body(:block, options)
    end

    def text_presenter(path, options)
      text = Texter::BuildText.call(path, @virtual_path, options)
      Texter::TextPresenter.new(text, self)
    end
  end
end
