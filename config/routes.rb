Potofgold::Application.routes.draw do

  root :to => 'pages#home'
  get '/rewards' => 'pages#rewards', as: :rewards
  get '/auth/twitter/callback' => 'sessions#create'
  delete '/signout' => 'sessions#destroy', as: :signout
  get '/pot_of_gold' => 'pages#pot_of_gold'

end
