Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show]

  resources :topics do
    resources :bookmarks
  end

  post :incoming, to: 'incoming#create'

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
