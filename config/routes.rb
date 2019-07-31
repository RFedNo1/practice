Rails.application.routes.draw do
  root "home#top"
  get "about" => "home#about"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id/edit" => "posts#edit"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  patch "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  # users
  get 'users/index' => "users#index"
  get "users/new" => "users#new"
  get "users/:id/edit" => "users#edit"
  get 'users/:id' => "users#show"
  post "users/create" => "users#create"
  patch "users/:id/update" => "users#update"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
