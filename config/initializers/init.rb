include LatoCore::Interface

# IMPOSTAZIONE VARIABILE PER ACCESSO ALLE LINGUE

CORE_LANG = core_loadModuleLanguages('lato_core')

# IMPOSTAZIONE UTENTE AMMINISTRATORE

if ActiveRecord::Base.connection.table_exists? 'lato_core_superusers' &&
   LatoCore::Superuser.first === nil
  LatoCore::Superuser.create(name: 'Admin', username: 'lato',
                             email: 'lato@mail.com', permission: 10,
                             password: 'password',
                             password_confirmation: 'password')
end
