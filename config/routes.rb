LatoCore::Engine.routes.draw do
  root 'back/back#home'

  # Authentication
  get 'login', to: 'back/authentication#login', as: 'login'
  post 'exec_login', to: 'back/authentication#exec_login', as: 'exec_login'
  delete 'exec_logout', to: 'back/authentication#exec_logout', as: 'exec_logout'

  # view richiesta email
  get 'password_forget', to: 'back/authentication#password_forget', as: 'password_forget'
  # invio email recupero psw
  post 'password_recover', to: 'back/authentication#password_recover', as: 'password_recover'
  # view inserimento nuova psw
  get 'password_edit/:token', to: 'back/authentication#password_edit', as: 'password_edit'
  # aggiornamento password
  post 'password_update', to: 'back/authentication#password_update', as: 'password_update'
  # Users
  resources :superusers, module: 'back'

end
