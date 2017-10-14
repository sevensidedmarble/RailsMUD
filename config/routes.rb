Rails.application.routes.draw do
  # root 'worlds#show'
  root :to => redirect('play')
  get 'play', to: 'worlds#show', as: 'play'

  get 'signup', to: 'users#new', as: 'signup'
  match "login", to: "sessions#create", as: 'login', via: [:get, :post]
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get ":page", to: "pages#show"

  resources :users
  resources :sessions

  get '/' => redirect('play')

  mount ActionCable.server => '/cable'
  # match "/telnet" => TelnetSinatra
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
