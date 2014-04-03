Dummy::Application.routes.draw do
  mount Texter::Engine => "/texter"
  root to: "pages#index"
end
