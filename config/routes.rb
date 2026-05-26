Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :students, only: [:create, :destroy]
end
