Texter::Engine.routes.draw do
  resources :texts, only: [:edit, :update], id: /[\w\.]+/
end
