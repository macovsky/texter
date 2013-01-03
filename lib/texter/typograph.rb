module Texter
  class Typograph < Struct.new(:text)
    def process(*attrs)
      return true if attrs.blank?

      options = attrs.flatten.inject({}){|memo, attr|
        memo.merge! attr => self.class.process(text.send(attr))
      }

      text.update_attributes options
    end

    def self.process(text)
      s = ArtTypograph.process(text)
      s.gsub! %r{</p>}m, "\n"
      s.gsub! %r{<p.*?>}, ''
      s.gsub! %r{</?(nobr|span).*?>}, ''
      s.strip
    end
  end
end
