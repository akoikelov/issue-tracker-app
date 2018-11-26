Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  authenticate :user do
    root 'index#index'
    resource :organization, only: [:new, :create]

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
