module Texter
  class CleanPreprocessor < Preprocessor
    def call
      body.to_s.gsub(/\r/, '').strip
    end
  end
end
