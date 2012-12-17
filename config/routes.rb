Potofgold::Application.routes.draw do

  resources :images

  resources :users

  resources :coupons

  resources :deals

  resources :advertisers

  root :to => 'pages#home'
  get '/auth/twitter/callback' => 'sessions#create'
  delete '/signout' => 'sessions#destroy', as: :signout
  get '/deal_stats/:id' => 'deals#stats', as: :deal_stats
  post '/tweet' => 'deals#tweet', as: :tweet

  post '/redeem/:id' => 'coupons#redeem', as: :redeem

  get 'mydeal' => 'deals#deal', as: :mydeal

end
