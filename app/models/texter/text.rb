module Texter
  class Text < ActiveRecord::Base
    BLOCK     = 'block'
    INLINE    = 'inline'
    TAG_TYPES = [BLOCK, INLINE]

    attr_writer :tag_type

    validates_uniqueness_of :path, allow_blank: false

    def self.find_or_initialize_by_path(path)
      text = find_or_initialize_by(path: path)
      text.body = text.get_body unless text.persisted?
      text
    end

    def to_param
      path
    end

    def get_body
      persisted? ? body : get_body_from_i18n
    end

    def tag_type
      TAG_TYPES.include?(@tag_type.to_s) ? @tag_type : BLOCK
    end

    private

    def get_body_from_i18n
      (match = path.match(%r{\A(#{I18n.available_locales.join("|")})\.})) || raise("cannot extract locale from #{path}")
      locale = match[1]
      I18n.t(path.sub(%r{\A#{locale}.}, ''), locale: locale, default: "").strip
    end
  end
end
