module Texter
  class Text < ActiveRecord::Base
    BLOCK = 'block'
    TAG_TYPES = [BLOCK, 'inline']

    attr_writer :tag_type

    validates_uniqueness_of :path, allow_blank: false

    def self.find_or_create_from_translations_by_path(path)
      text = find_or_initialize_by(path: path)
      text.new_record? && text.update_attributes(text.default_attributes)
      text
    end

    def to_param
      path
    end

    def get_body(options = {})
      persisted? ? body : Texter.translate(path, options)
    end

    def tag_type
      TAG_TYPES.include?(@tag_type.to_s) ? @tag_type : BLOCK
    end

    def default_attributes
      { body: get_body }
    end
  end
end
