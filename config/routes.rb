Rails.application.routes.draw do
  root 'pages#home'
  resources :users, only: [:show]
  devise_for :users,
              path: '',
              controllers: { registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
