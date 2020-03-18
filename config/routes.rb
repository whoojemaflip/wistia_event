WistiaEvent::Engine.routes.draw do
  resources :events, only: [:index, :create]
end
