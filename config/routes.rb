Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  get 'admin', to: 'admin#dashboard'

  get 'dashboard', to:'user_dashboard#dashboard'

  resources :products
  resources :plans
  resources :pricing, only: :index
  resources :subscriptions

  get '/card/new' => "payment_methods#new_card", as: :add_payment_method
  post "/card" => "payment_methods#create_card", as: :create_payment_method
  get '/card/:id' => "payment_methods#show", as: :card
  delete '/card/:id' => "payment_methods#destroy", as: :remove_card
  get '/cards' => "payment_methods#cards", as: :cards

end
