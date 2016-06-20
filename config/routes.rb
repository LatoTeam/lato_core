LatoCore::Engine.routes.draw do
  root 'back/back#home'

  # Authentication
  get 'login', to: 'back/authentication#login', as: 'login'
  
  post 'exec_login', to: 'back/authentication#exec_login', as: 'exec_login'
  delete 'exec_logout', to: 'back/authentication#exec_logout', as: 'exec_logout'

  # Password recover
  get 'change_password_form', to: 'back/authentication#change_password_form', as: 'change_password'
  post 'recover_password', to: 'back/authentication#recover_password', as: 'recover_password'
  post 'exec_change_password', to: 'back/authentication#exec_change_password', as: 'exec_change_password'


  # Users
  resources :superusers, module: 'back'

end
