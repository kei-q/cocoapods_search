Rails.application.routes.draw do
  root 'pod_libraries#index'

  resources :pods, controller: :pod_libraries, only: [:index, :show]
  resources :authors, only: [:show]
end
