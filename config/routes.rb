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
  get 'advertiser_sign_in' => 'sessions#advertiser_sign_in'

  post '/redeem/:id' => 'coupons#redeem', as: :redeem

  get 'mydeal' => 'deals#deal', as: :mydeal

end
