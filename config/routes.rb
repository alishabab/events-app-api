Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index create]
  resources :events, only: %i[index create show update destroy] do
    resources :invitations, only: %i[create destroy]
    get 'attendees', to: 'invitations#attendees'
  end
  get 'users/attendees', to: 'users#attendees'
  get 'users/:id/created_events', to: 'events#created_events'
  get 'users/:id/attended_events', to: 'events#attended_events'
  post 'login', to: 'authentication#login'
  get 'auto_login', to: 'authentication#auto_login'
  get 'user_is_authed', to: 'authentication#user_is_authed'
end
