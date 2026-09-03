Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  resources :users, only: [:show]

  resources :tweets do
  resources :likes, only: [:create, :destroy]
  resources :want_to_sings, only: [:create, :destroy]
end

  get 'static_pages/top' => 'static_pages#top'
  root 'static_pages#top'  
end