Potofgold::Application.routes.draw do

  resources :users

  resources :coupons

  resources :deals

  resources :advertisers

  root :to => 'pages#home'
  get '/auth/twitter/callback' => 'sessions#create'
  delete '/signout' => 'sessions#destroy', as: :signout

end
