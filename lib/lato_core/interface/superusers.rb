module LatoCore
  # This module contains function used to manage superusers.
  module Interface::Superusers

    # This function send a notification email to user with title and
    # description.
    def core_notifyUser(user, title, message)
      # richiamo mailer corretto
      LatoCore::SuperusersMailer.notify(user, title, message).deliver
    end

    # This function return a list of possible permissions for superusers with
    # the string name for every permission.
    def core_getUsersPermissions
      # definisco permessi iniziali
      initial_permissions = (1...11).to_a

      unpermitted = core_getHideUsersPermissionsSettings
      permitted_permissions = initial_permissions
      permitted_permissions = initial_permissions - unpermitted if unpermitted

      permissions = []
      names = core_getUsersPermissionsNamesSettings
      return permitted_permissions if !names

      permitted_permissions.each do |permission|
        names.each do |name|
          permissions.push([permission, name.last]) if permission === name.first.to_i
        end
      end

      return permissions
    end

    # This function return an array that tells how some users can't see
    # other users with a specific permission value.
    def core_getHideUsersSettings
      return CORE_SUPERUSERSHIDESETTINGS if defined? CORE_SUPERUSERSHIDESETTINGS
      # accedo al config.yml
      directory = core_getCacheDirectory
      config = YAML.load(
        File.read(File.expand_path("#{directory}/config.yml", __FILE__))
      )
      # controllo che il file di configurazione esista e abbia i dati necessari
      return false if !config['hide_users'] || config['hide_users'].nil?
      # estraggo lista impostazioni utenti da nascondere
      settings = config['hide_users'].split(',')
      # definisco output
      output = []
      # riempio file di output
      settings.each do |setting|
        setting.slice! ' '
        if setting
          values = setting.split('to')
          raise 'Permission value not correct on hide_users config' unless (1..11).to_a.include? values.first.to_i
          raise 'Permission value not correct on hide_users config' unless (1..11).to_a.include? values.last.to_i
          output.push([values.first, values.last])
        end
      end
      # ritorno l'output
      return output
    end

    # This function return an array of permissions value that must be hidden
    # from the user interface.
    def core_getHideUsersPermissionsSettings
      return CORE_SUPERUSERSPERMISSIONSHIDESETTINGS if defined? CORE_SUPERUSERSPERMISSIONSHIDESETTINGS
      # accedo al config.yml
      directory = core_getCacheDirectory
      config = YAML.load(
        File.read(File.expand_path("#{directory}/config.yml", __FILE__))
      )
      # controllo che il file di configurazione esista e abbia i dati necessari
      return false if !config['hide_users_permissions'] || config['hide_users_permissions'].nil?
      # estraggo lista impostazioni utenti da nascondere
      settings = config['hide_users_permissions'].to_s.split(',')
      # definisco output
      output = []
      # riempio file di output
      settings.each do |setting|
        setting.slice! ' '
        if setting
          raise 'Permission value not correct on hide_users_permissions config' unless (1..11).to_a.include? setting.to_i
          output.push(setting.to_i)
        end
      end
      # ritorno l'output
      return output
    end

    # This function return an array with correct name fr every permission
    # if name is set on config file.
    def core_getUsersPermissionsNamesSettings
      return CORE_SUPERUSERSPERMISSIONSNAMESSETTINGS if defined? CORE_SUPERUSERSPERMISSIONSNAMESSETTINGS
      # accedo al config.yml
      directory = core_getCacheDirectory
      config = YAML.load(
        File.read(File.expand_path("#{directory}/config.yml", __FILE__))
      )
      # controllo che il file di configurazione esista e abbia i dati necessari
      return false if !config['rename_users_permissions'] || config['rename_users_permissions'].nil?
      # estraggo lista impostazioni utenti da nascondere
      settings = config['rename_users_permissions'].split(',')
      # definisco output
      output = []
      # riempio file di output
      settings.each do |setting|
        setting.slice! ' '
        if setting
          values = setting.split('-')
          raise 'Permission value not correct on rename_users_permissions config' unless (1..11).to_a.include? values.first.to_i
          output.push([values.first, values.last])
        end
      end
      # ritorno l'output
      return output
    end

    # This function tells if is possible for user to recover his password.
    def core_getRecoveryPasswordPermission
      return CORE_RECOVERYPASSWORDPERMISSION if defined? CORE_RECOVERYPASSWORDPERMISSION
      # accedo al config.yml
      directory = core_getCacheDirectory
      config = YAML.load(
        File.read(File.expand_path("#{directory}/config.yml", __FILE__))
      )
      # controllo che il file di configurazione esista e abbia i dati necessari
      return false if !config['recovery_password'] || config['recovery_password'].nil?
      # ritorno valore letto
      return config['recovery_password']
    end

  end
end
