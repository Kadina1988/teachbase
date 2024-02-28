Rails.application.routes.draw do
  devise_for :users

  resources :questions, shallow: true do
    resources :answers, only: [:create]
  end

  root to: 'questions#index'

end
