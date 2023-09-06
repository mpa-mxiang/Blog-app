Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      post 'like', on: :member
      resources :comments, only: [:create, :new]
    end
  end

  post '/posts/:post_id/likes', to: 'likes#create', as: 'post_likes'
end
