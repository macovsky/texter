require 'texter/engine'
require 'texter/configuration'

module Texter
  class <<self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    # @param [Symbol, String] name
    def find_formatter(name)
      "Texter::#{name.to_s.classify}Formatter".constantize
    end

    # @param [Symbol, String] name
    def find_preprocessor(name)
      "Texter::#{name.to_s.classify}Preprocessor".constantize
    end

    def t(path, options = {})
      I18n.t(path, {scope: configuration.i18n_scope}.merge(options))
    end
  end
end
