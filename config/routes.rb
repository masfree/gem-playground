Rails.application.routes.draw do
  resources :messages, except: [:show, :new]
  root to: "messages#index"
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
