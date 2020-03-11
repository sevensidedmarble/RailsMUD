Rails.application.routes.draw do
  # TODO: Should the root show worlds instead?
  # root 'worlds#show'

  root to: redirect('play')
  get 'play', to: 'worlds#show', as: 'play'

  get 'signup', to: 'users#new', as: 'signup'
  match 'login', to: 'sessions#create', as: 'login', via: %i[get post]
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'home', to: 'pages#home', as: 'home'

  resources :users
  resources :sessions

  get '/' => redirect('play')

  mount ActionCable.server => '/cable'
  # TODO: Work on below
  # match "/telnet" => TelnetSinatra
end
