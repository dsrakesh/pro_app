Rails.application.routes.draw do
  root :to => 'sessions#new'
  resources :projects do
    get '/destroy', to: 'projects#destroy'
    resources :tasks do
      get '/destroy', to: 'tasks#destroy'
    end
  end
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'
end