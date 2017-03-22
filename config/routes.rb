Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/reddit/callback', to: 'sessions#create'
  get "/dashboard", to: "dashboard#show"
  get '/logout', to: 'sessions#destroy'
  root "home#index"
  resources :subreddits, only: [:show]
end
