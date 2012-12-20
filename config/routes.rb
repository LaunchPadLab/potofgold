Potofgold::Application.routes.draw do

  resources :images

  resources :coupons

  resources :deals

  root :to => 'pages#home'
  get '/auth/twitter/callback' => 'sessions#create'
  delete '/signout' => 'sessions#destroy', as: :signout
  get '/deal_stats/:id' => 'deals#stats', as: :deal_stats
  post '/tweet' => 'deals#tweet', as: :tweet
  get 'advertiser_sign_in' => 'sessions#advertiser_sign_in'

  post '/redeem/:id' => 'coupons#redeem', as: :redeem

end
