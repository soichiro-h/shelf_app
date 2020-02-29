Rails.application.routes.draw do
  
  root 'static#home'
  get 'users/show'
  get '/profile', to: 'users#show'
  get '/tags', to: 'tags#index'
  post '/tags', to: 'tags#update'
  post '/tag-new', to: 'tags#create'
  delete '/tag/:id', to: 'tags#destroy'
  

  devise_for :users
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/signup', to: 'devise/registrations#new'
    get '/profile_edit', to: 'devise/registrations#edit'
    delete '/logout', to: 'devise/sessions#destroy'
  end
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
