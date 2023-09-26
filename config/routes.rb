Rails.application.routes.draw do

 devise_for :users

 devise_scope :user do
   post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
 end

 namespace :admin do
   patch "withdraw/:id" => "users#withdraw", as: "withdraw"
 end
#   resources :users, only: [:show, :edit, :destroy, :update]
#   resources :posts
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follows, :followers, :favorites
    end
    resource :relationships, only: [:create, :destroy]
  end
    resources :posts do  #postsコントローラへのルーティング
    resources :comments, only: [:create, :destroy]  #commentsコントローラへのルーティング
    resource :favorites, only: [:create, :destroy]
  end

  root to: 'posts#index'
  get "new_index" => "posts#new_index"
  get "search_tag" => "posts#search_tag"
  get 'homes/about'
  get "search" => "searches#search"
  get '/user/check' => 'users#check'
  patch '/user/withdraw' => 'users#withdraw'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
