require 'texter/engine'
require 'simple_form'

module Texter
  # [Array<String>] body attributes for text
  # it can be %w{body_ru body_en} for instance if you use multiple languages
  mattr_accessor :bodies
  self.bodies = %w{body}

  # [Array<Symbol>]
  mattr_accessor :preprocessors
  self.preprocessors = [:clean]

  # [Symbol]
  mattr_accessor :formatter
  self.formatter = :simple

  class <<self
    # @param [Symbol, String] name
    def find_formatter(name)
      "Texter::#{name.to_s.classify}Formatter".constantize
    end

    # @param [Symbol, String] name
    def find_preprocessor(name)
      "Texter::#{name.to_s.classify}Preprocessor".constantize
    end

    def translate(path, options = {})
      I18n.t(path, { :scope => 'texter' }.merge(options))
    end
  end
end
