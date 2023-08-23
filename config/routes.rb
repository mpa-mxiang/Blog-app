Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
    # All users page
    get '/users', to: 'users#index', as: 'users'

    # Single user page
    get '/users/:id', to: 'users#show', as: 'user'
  
    get '/posts', to: 'posts#index', as: 'posts'
    get '/posts/:id', to: 'posts#show', as: 'post'
end

