Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:show] do
    get :mytopics
  end

  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:create, :destroy]
    end
  end

  post :incoming, to: 'incoming#create'

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
#
