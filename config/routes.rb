Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root to: "home#index"

  get 'home/index'
  get 'home/show'

  # 2FA機能
  get 'two_factor_authentication/show', to: 'two_factor_authentication#show', as: :two_factor_authentication_show
  post 'two_factor_authentication/update', to: 'two_factor_authentication#update', as: :two_factor_authentication_update
  
  ## 開発環境用letter_opener
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
