Rails.application.routes.draw do

  resources :notifications, only: [:index] do
    post 'callback', on: :collection
  end

  root 'notifications#index'

  get "*path" => redirect("/")
  post "*path" => redirect("/")
end
