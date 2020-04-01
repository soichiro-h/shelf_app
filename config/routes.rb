Rails.application.routes.draw do
  
  root 'static#home'
  get 'users/show'
  get '/profile', to: 'users#show'
  post '/comment', to: 'users#comment_update'
  
  get '/tags', to: 'tags#index'
  post '/tags', to: 'tags#update'
  post '/tag-new', to: 'tags#create'
  delete '/tag/:id', to: 'tags#destroy'
  
  get '/books', to: 'books#index'
  post '/book-new', to: 'books#new'
  post '/books', to: 'books#create'
  get 'details/:id', to: 'books#show'
  #get '/details/:id/edit', to: 'books#edit'
  #delete '/details/:id', to: 'books#destroy'
  
  post '/sort_by_tags', to: 'books#sort_by_tags'
  post '/sort_by', to: 'books#sort_by'
  get '/serach_books', to: 'books#search'
  
  resources :books

  devise_for :users, :controllers => { :registrations => :registrations }
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/signup', to: 'devise/registrations#new'
    get '/profile_edit', to: 'devise/registrations#edit'
    delete '/logout', to: 'devise/sessions#destroy'
  end
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
