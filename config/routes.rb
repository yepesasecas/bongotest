Rails.application.routes.draw do

  resources :notifications, only: [:index] do
    post 'callback', on: :collection
    get 'callback', to: redirect(root_path)
  end

  root 'notifications#index'
end
