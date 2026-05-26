Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :students, only: [:create, :destroy]

  resources :schools, only: [] do
    resources :school_classes, path: 'classes', only: [:index] do
      resources :students, only: [:index]
    end
  end
end
