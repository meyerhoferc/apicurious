Rails.application.routes.draw do
  get '/auth/reddit/callback', to: 'sessions#create'
  get "/dashboard", to: "dashboard#show"
  get '/logout', to: 'sessions#destroy'
  root "home#index"
  resources :subreddits, only: [:show] do
    resources :posts, only: [:show]
  end
end
