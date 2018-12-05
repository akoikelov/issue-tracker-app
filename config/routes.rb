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

    resources :organizations, only: %i[new create index] do
      collection do
        post ':id/choose', action: :choose, as: 'choose'
      end
    end

    namespace 'system' do
      resources :dashboard, only: %i[index]
      resources :profile, only: %i[index] do
        collection do
          patch '', action: :update, as: 'update'
        end
      end
    end

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
