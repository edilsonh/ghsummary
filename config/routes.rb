Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/summaries/search", to: "summaries#search"
  get "/summaries/:username", to: "summaries#show", as: "summary"

  root "homepage#index"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
