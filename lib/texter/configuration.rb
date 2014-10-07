module Texter
  class Configuration
    attr_accessor :formatter, :preprocessors, :i18n_scope

    def initialize
      @formatter     = :simple
      @preprocessors = [:clean]
      @i18n_scope    = "texter"
    end
  end
end
