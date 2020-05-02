Rails.application.routes.draw do
  
  root 'static#home'
  get 'users/show'
  get '/profile', to: 'users#show'
  post '/comment', to: 'users#comment_update'
  
  post '/test_login', to: 'application#login_as_test_user'
  
  get '/tags', to: 'tags#index'
  post '/tags', to: 'tags#update'
  post '/tag-new', to: 'tags#create'
  delete '/tag/:id', to: 'tags#destroy'
  get 'clear_tags_error', to: 'tags#clear_tags_error'
  
  get '/books', to: 'books#index'
  post '/book-new', to: 'books#new'
  post '/books', to: 'books#create'
  get '/details/:id', to: 'books#show'
  
  post '/sort_by_tags', to: 'books#sort_by_tags'
  post '/sort_by', to: 'books#sort_by'
  get '/serach_books', to: 'books#search_books'
  
  get '/guess', to: 'books#search_rakuten'
  
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
