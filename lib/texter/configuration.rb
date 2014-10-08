module Texter
  class Configuration
    attr_accessor :formatter,
                  :preprocessors,
                  :i18n_scope,
                  :can_be_edited

    def initialize
      @formatter     = :simple
      @preprocessors = [:clean]
      @i18n_scope    = 'texter'
      @can_be_edited = false
    end
  end
end
