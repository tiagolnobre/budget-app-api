Rails.application.routes.draw do
  # resources :users, param: :_username

  # users
  get "users/me" => "users#show"
  post "users" => "user#create"

  # transactions
  get "transactions" => "transactions#show"
  post "transactions/import" => "transactions#import_file"

  post '/auth/token', to: 'authentication#login'

  get '/*a', to: 'application#not_found'
end
