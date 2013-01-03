module Texter
  class TextFactory < Struct.new(:path, :tag_type, :virtual_path)
    def build
      text = Texter::Text.find_or_initialize_by_path(full_path)
      text.tag_type = tag_type
      Texter::TextDecorator.new(text)
    end

    private

    def full_path
      if path.to_s.first == "."
        if virtual_path
          virtual_path.gsub(%r{/_?}, ".") + path.to_s
        else
          raise "Cannot use #{path.inspect} shortcut because path is not available"
        end
      else
        path
      end
    end
  end
end
