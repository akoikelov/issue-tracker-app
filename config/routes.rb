Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  authenticate :user do
    root to: redirect('/system/dashboard')
    resource :organization, only: %i[new create]

    scope 'system' do
      get '/dashboard', to: 'system/dashboard#index'
    end

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
