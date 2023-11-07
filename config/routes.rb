Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }

  resources :posts do
    member do
      post :like
      delete :unlike
    end
    resources :comments, only: %i[create destroy]
  end

  resources :users, only: :show do
    member do
      get :followers
      get :following
      post :follow
      delete :unfollow
    end
    get '/search', to: 'users#search', on: :collection
    get 'explore', to: 'users#explore', on: :collection
  end

  resources :bookmarks, only: %i[index create destroy]

  root 'home_pages#home'
end
