Rails.application.routes.draw do
  resources :books
  get 'home', to: "home#index"
  root 'books#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  get 'admin', to: 'admin#dashboard'
  get 'admin/books', to: 'admin#books'

  get 'dashboard', to:'user_dashboard#dashboard'
  get 'dashboard/purchases', to: "user_dashboard#purchases"

  get 'generate', to: "bills#generate", as: :generate_bill

  resources :products
  resources :plans
  resources :charges, only: [:new, :create]

  get 'payment_success', to: "charges#success", as: :success_payment

  get  'pricing', to: "pricing#index", as: :pricing
  resources :subscriptions

  get '/card/new' => "payment_methods#new_card", as: :add_payment_method
  post "/card" => "payment_methods#create_card", as: :create_payment_method
  get '/card/:id' => "payment_methods#show", as: :card
  delete '/card/:id' => "payment_methods#destroy", as: :remove_card
  get '/cards' => "payment_methods#cards", as: :cards
  post "/bank_account" => "payment_methods#add_bank_account", as: :add_bank_account
  get "/bank_account/:id" => "payment_methods#bank_account", as: :bank_account
end
