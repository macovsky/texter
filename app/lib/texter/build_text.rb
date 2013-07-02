module Texter
  class BuildText
    include CallableClass

    attr_reader :path, :tag_type, :virtual_path

    # @param [String] path
    # @param [Symbol] tag_type (:block, :inline)
    # @param [String, NilClass] virtual_path
    def initialize(path, tag_type, virtual_path)
      @path         = path
      @tag_type     = tag_type
      @virtual_path = virtual_path
    end

    def call
      text = Texter::Text.find_or_initialize_by_path(full_path)
      text.tag_type = tag_type
      text
    end

    private

    def full_path
      return path unless relative_path?

      if virtual_path
        virtual_path.gsub(%r{/_?}, ".") + path.to_s
      else
        raise "Cannot use #{path.inspect} shortcut because path is not available"
      end
    end

    def relative_path?
      path.starts_with?(".")
    end
  end
end
