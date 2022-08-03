Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :ideas do
    resources :reviews, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  post "/ideas/:idea_id/likes/on_index" => "likes#create_on_index", :as => :like_idea_on_index
  delete "/ideas/:idea_id/likes/:id/on_index" => "likes#destroy_on_index", :as => :destroy_idea_on_index

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  root "ideas#index"
end
