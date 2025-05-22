Rails.application.routes.draw do
  resources :books
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  root to: "homes#top"
  # get 'homes/about' => 'homes#about', as: 'about'
  get 'home/about' => 'homes#about', as: 'about' 
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
