Rails.application.routes.draw do
  devise_for :users
  root 'users#index'  

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      post 'like', on: :member
      resources :comments, only: [:create, :new]
    end
  end

  post '/posts/:post_id/likes', to: 'likes#create', as: 'post_likes'
end
