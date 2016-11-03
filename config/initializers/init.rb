include LatoCore::Interface

# Set default languages

CORE_LANG = core_loadModuleLanguages('lato_core')

# Create first user if not exist

if ActiveRecord::Base.connection.table_exists? 'lato_core_superusers'
  if LatoCore::Superuser.where(permission: 10).empty?
    LatoCore::Superuser.create(name: 'Admin', username: 'lato',
    email: 'lato@mail.com', permission: 10, password: 'password',
    password_confirmation: 'password')
  end
end
