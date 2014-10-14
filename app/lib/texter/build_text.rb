module Texter
  class BuildText
    include CallableClass

    attr_reader :path, :virtual_path, :options

    # @param [String] path
    # @param [String, NilClass] virtual_path
    # @param [Hash] options
    def initialize(path, virtual_path, options)
      @path         = path
      @virtual_path = virtual_path
      @options      = options
    end

    def call
      Texter::Text.find_or_initialize_by(path: full_path)
    end

    private

    def full_path
      locale = (options[:locale] || I18n.locale).to_s
      [locale, Texter.configuration.i18n_scope, i18n_path].join(".")
    end

    def i18n_path
      return path unless relative_path?

      if virtual_path
        virtual_path.gsub(%r{/_?}, ".") + path.to_s
      else
        raise "Cannot use #{path.inspect} shortcut because path is not available"
      end
    end

    def relative_path?
      path.starts_with?(".")
    end
  end
end
