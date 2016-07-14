module LatoCore
  module Interface
    # Insieme di funzioni che gestiscono varie impostazioni sulla gestione
    # e visualizzazione dei superusers
    module Superusers

      # Funzione che richiede come parametri un utente, un titolo e un messaggio
      # e invia tale contenuto come notifica email all'utente
      def core_notifyUser(user, title, message)
        # richiamo mailer corretto
        LatoCore::SuperusersMailer.notify(user, title, message).deliver
      end

      # Funzione che ritorna una lista dei possibili permessi per gli utenti
      # utilizzando la seguente struttura: [[1, 'Nome'], [2, 'Nome']].
      # Il risultato della funzione e' compatibile con la componente input select
      # di lato_view
      def core_getUsersPermissions
        # definisco permessi iniziali
        initial_permissions = (1...11).to_a

        unpermitted = core_getHideUsersPermissionsSettings
        return initial_permissions if !unpermitted
        permitted_permissions = initial_permissions - unpermitted

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

      # Funzione che legge il file di cache e, se e' stato impostato per nascondere
      # determinati utenti ad altri utenti, ritorna tali informazione attraverso
      # un array con la seguente struttura: [[1,4], [1,3]]
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

      # Funzione che legge il file di configurazione e, se e' stato impostato di
      # nascondere determinati permessi di utenze dall'interfaccia, ritorna i
      # valori da nascondere in un array
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

      # Funzione che legge il file di configurazione e, se e' stato impostato di rinominare
      # dei valori di permessi degli utenti, ritorna tali valori in un array con la seguente
      # struttura: [[1,'nome'], [4,'nome']]
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

    end
  end
end
