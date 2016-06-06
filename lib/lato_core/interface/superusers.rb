module LatoCore
  module Interface
    # Insieme di funzioni che gestiscono varie impostazioni sulla gestione
    # e visualizzazione dei superusers
    module Superusers

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
        return false unless config || config['hide_users'] || config['hide_users'].nil? || config['hide_users'].blank?
        # estraggo lista impostazioni utenti da nascondere
        settings = config['hide_users'].split(',')
        # definisco output
        output = []
        # riempio file di output
        settings.each do |setting|
          setting.slice! ' '
          values = setting.split('to')
          output.push([values.first, values.last])
        end
        # ritorno l'output
        output
      end

    end

  end
end
