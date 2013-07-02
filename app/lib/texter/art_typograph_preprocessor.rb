require 'art_typograph'

module Texter
  class ArtTypographPreprocessor < Preprocessor
    def call
      processed = ArtTypograph.process(body)
      processed.gsub! %r{</p>}m, "\n"
      processed.gsub! %r{<p.*?>}, ''
      processed.gsub! %r{</?(nobr|span).*?>}, ''
      processed.strip
    end
  end
end
