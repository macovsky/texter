module Texter
  class RunPreprocessorsOnText
    include CallableClass

    attr_reader :text, :options

    # @param [Texter::Text] text
    # @param [Hash] options ({ force: true } to force processing)
    def initialize(text, options = {})
      @text = text
      @options = options
    end

    def call
      if text.body_changed? || options[:force]
        processed = Texter.configuration.preprocessors.inject(text.body) { |memo, preprocessor| Texter.find_preprocessor(preprocessor).call(memo) }
        text.body = processed
      end
    end
  end
end
