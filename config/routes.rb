Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/show'
  get 'posts/update'
  get 'posts/destroy'
  root 'forums#index'
  get '/users', to: 'users#index', as: 'users'
  get '/users/new', to: 'users#new', as: 'new_user'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  post '/users', to: 'users#create'
  patch '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
  post '/users/:id/logon', to: 'users#logon', as: 'user_logon'
  delete '/logoff', to: 'users#logoff', as: 'user_logoff'
  
  resources :forums do
    resources :posts, shallow: true, except: [:index]
    resources :subscriptions, shallow: true, except: [:index]
  end
  
  get '/subscriptions', to: 'subscriptions#index', as: 'subscriptions'
end
