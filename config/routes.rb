Potofgold::Application.routes.draw do

  resources :users

  resources :coupons

  resources :deals

  resources :advertisers

  root :to => 'pages#home'
  get '/rewards' => 'pages#rewards', as: :rewards
  get '/auth/twitter/callback' => 'sessions#create'
  delete '/signout' => 'sessions#destroy', as: :signout
  get '/pot_of_gold' => 'pages#pot_of_gold'

end
