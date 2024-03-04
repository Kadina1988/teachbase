Rails.application.routes.draw do
  devise_for :users

  resources :questions, shallow: true do
    resources :answers, only: %i[create destroy]
  end

  resources :files, only: :destroy

  root to: 'questions#index'

end
