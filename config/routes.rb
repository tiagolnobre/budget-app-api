# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :users, param: :_username

  # users
  get "users/me" => "users#show"
  post "users" => "users#create"

  # transactions
  get "transactions" => "transactions#show"
  post "transactions/import" => "transactions#import_file"

  get "account/status" => "accounts#show"

  post "/auth/login", to: "authentication#login"

  match "*path", via: [:options], to: ->(_) { [204, {"Content-Type" => "text/plain"}, []] }

  get "/*a", to: "application#not_found"
end
