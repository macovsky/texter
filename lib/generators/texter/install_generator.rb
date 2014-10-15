require 'rails/generators/base'

module Texter
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_initializer
        template "texter.rb", "config/initializers/texter.rb"
      end

      def copy_locale
        copy_file "../../../config/locales/texter.yml", "config/locales/texter.yml"
      end

      def mount
        route "mount Texter::Engine => '/texter'"
      end
    end
  end
end
