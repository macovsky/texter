module Texter
  class Engine < ::Rails::Engine
    isolate_namespace Texter

    initializer 'texter.action_view' do |app|
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send(:include, Texter::TextsHelper)
      end
    end
  end
end
