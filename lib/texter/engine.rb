require 'draper'
require 'simple_form'
require 'RedCloth'
require 'art_typograph'
require 'texter/typograph'
require 'texter/clean_body'
require 'texter/text_factory'

module Texter
  class Engine < ::Rails::Engine
    isolate_namespace Texter

    initializer 'texter.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Texter::TextsHelper
      end
    end
  end
end
