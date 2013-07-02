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
