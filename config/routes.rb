Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users

  resources :posts
  resources :users, only: :show

  root 'home_pages#home'
end
