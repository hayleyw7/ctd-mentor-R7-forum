Rails.application.routes.draw do
  # Root path
  root 'forums#index'

  # User routes
  get '/users', to: 'users#index', as: 'users'
  get '/users/new', to: 'users#new', as: 'new_user'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  post '/users', to: 'users#create'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
  post '/users/:id/logon', to: 'users#logon', as: 'user_logon'
  delete '/logoff', to: 'users#logoff', as: 'user_logoff'

  # Forum and nested resources
  resources :forums do
    resources :posts, shallow: true, except: [:index]
    resources :subscriptions, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end

  # Standalone subscriptions index route
  get '/subscriptions', to: 'subscriptions#index', as: 'subscriptions'
end
