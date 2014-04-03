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
      attributes.each do |attr|
        body = text.send(attr)
        processed = Texter.preprocessors.inject(body) { |memo, preprocessor| Texter.find_preprocessor(preprocessor).call(memo) }
        text.send "#{attr}=", processed
      end
    end

    private

    def attributes
      return Texter.bodies if options[:force]
      Texter.bodies & text.changed
    end
  end
end
