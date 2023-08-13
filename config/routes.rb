Rails.application.routes.draw do
  
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'posts#index'
  devise_for :users
  resources :users, only: [:show, :edit, :destroy, :update]
  resources :posts

  get 'homes/about'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
