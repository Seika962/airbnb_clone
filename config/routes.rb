Rails.application.routes.draw do
  root 'pages#home'
  resources :users, only: [:show]

  resources :rooms do
    member do
      get 'listing','pricing','description','photos','amenities','location','preload','preview'
    end

    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create] # if we nest like this, parent id(room id) is required everytime we access to children(photos and reservations) 
  end

  get 'trips', to: 'reservations#trips'
  get 'reservations', to: 'reservations#reservations'
  get 'search', to: 'pages#search'
  devise_for :users,
              path: '',
              controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]
end
