Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
    # All users page
    get '/users', to: 'users#index', as: 'users'

    # Single user page
    get '/users/:id', to: 'users#show', as: 'user'
  
    # All posts by a given user page
    get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  
    # Single post page
    get '/posts/:id', to: 'posts#show', as: 'post'
  
    # ... Other routes for your application ...
  
    # Root route (optional)
    root 'welcome#index'
end
