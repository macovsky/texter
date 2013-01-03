module Texter
  class Text < ActiveRecord::Base
    TAG_TYPES = %w{block inline}
    attr_writer :tag_type

    attr_accessible *Texter.bodies, :tag_type

    validates_uniqueness_of :path, :allow_blank => false
    validates_presence_of *Texter.bodies

    def self.find_or_create_from_translations_by_path(path)
      text = find_or_initialize_by_path(path)
      text.new_record? && text.update_attributes(text.default_attributes)
      text
    end

    def to_param
      path
    end

    def get_body(options = {})
      persisted? ? body : I18n.t(path, {:scope => 'texts'}.merge(options)).strip
    end

    def tag_type
      TAG_TYPES.include?(@tag_type.to_s) ? @tag_type : TAG_TYPES.first
    end

    def default_attributes
      {:body => get_body}
    end
  end
end
