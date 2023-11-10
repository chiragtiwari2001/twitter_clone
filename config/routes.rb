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
    resources :comments, only: %i[create update destroy]
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

  post 'stripe/webhooks', to: 'stripe/webhooks#create'
  get 'pricing', to: 'stripe/checkout#pricing'
  post 'stripe/checkout', to: 'stripe/checkout#checkout'
  get 'stripe/checkout/success', to: 'stripe/checkout#success'
  get 'stripe/checkout/cancel', to: 'stripe/checkout#cancel'
  post 'stripe/billing_portal', to: 'stripe/billing_portal#create'
  get 'notification', to: 'home_pages#notification'
  # stripe listen --forward-to localhost:4242/webhook

  root 'home_pages#home'
end
