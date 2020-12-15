Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'login', to: 'authentication#login'
  get 'auto_login', to: 'authentication#auto_login'
  get 'user_is_authed', to: 'authentication#user_is_authed'
end
