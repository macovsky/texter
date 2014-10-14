Texter::Engine.routes.draw do
  resources :texts, only: [:edit, :update, :show], id: /[\w\.]+/
end
