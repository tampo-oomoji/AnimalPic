Rails.application.routes.draw do

 devise_for :users
 
 devise_scope :user do
   post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
 end
 
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

    resources :posts do  #postsコントローラへのルーティング
    resources :comments, only: [:create]  #commentsコントローラへのルーティング
  end

  root to: 'posts#index'

  resources :users, only: [:show, :edit, :destroy, :update]
  resources :posts

  get 'homes/about'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
