Rails.application.routes.draw do
  get 'questions/index'

  get 'questions/new'

  get 'questions/show'

  get 'questions/edit'

  get 'questions/destroy'

  resources :posts

  resources :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
