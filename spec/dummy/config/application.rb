require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require
require 'texter'

module Dummy
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.encoding = "utf-8"
  end
end
