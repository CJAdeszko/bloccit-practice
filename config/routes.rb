Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end

  #shallow nest comments under posts
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote #create new route as posts/:id/up-vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote #create new route as posts/:id/down-vote
  end

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
