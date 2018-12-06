Rails.application.routes.draw do

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search

  # Authentication routes
  resources :sessions
  resources :users
  get 'users/new', to: 'users#new', as: :signup
  get 'user/edit', to: 'users#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Routes for assignments
  get 'assignments/new', to: 'assignments#new', as: :new_assignment
  post 'assignments', to: 'assignments#create', as: :assignments
  patch 'assignments/:id/terminate', to: 'assignments#terminate', as: :terminate_assignment

  # Toggle paths



  # Other custom routes
  patch 'investigations/:id/close', to: 'investigations#close', as: :close_investigation


  # Routes for searching
  get 'criminals/search', to: 'criminals#search', as: :criminal_search
  get 'officers/search', to: 'officers#search', as: :officer_search
  get 'investigations/search', to: 'investigations#search', as: :investigation_search
  
  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :criminals
  resources :officers
  resources :units
  resources :investigations
  resources :crimes
  resources :suspects


  # You can have the root of your site routed with 'root'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
