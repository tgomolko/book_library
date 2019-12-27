Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  get 'admin', to: 'admin#dashboard'

  resources :products
  resources :plans
  resources :pricing, only: :index
  resources :subscriptions
  get '/card/new' => "payment_methods#new_card", as: :add_payment_method
  post "/card" => "payment_methods#create_card", as: :create_payment_method
  get '/card/:id' => "payment_methods#show", as: :show_card
  delete '/card/:id' => "payment_methods#destroy", as: :remove_card
end
