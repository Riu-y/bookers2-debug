Rails.application.routes.draw do
  devise_for :users
  resources :users
  # get "users/:id" => "users#show"
  resources :books
  root 'home#top'
  get 'home/about' => 'home#about'

end