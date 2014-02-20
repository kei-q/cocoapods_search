Rails.application.routes.draw do
  root 'pod_libraries#index'

  resources :pod_libraries, only: [:index]
end
