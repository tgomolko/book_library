Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  get 'admin', to: 'admin#dashboard'

  resources :products
  resources :plans
  resources :pricing, only: :index
  resources :subscriptions
end
