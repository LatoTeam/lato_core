module LatoCore
  module Interface
    # Insieme di funzioni che permettono di ottenere informazioni sulla
    # applicazione principale e sulle altre gemme che lavorano su di essa
    module Communication

      # Ritorna l'url relativo della directory a cui rimandare dopo
      # aver effettuato il login in lato. Se tale valore non e' settato
      # nel file di configurazione di lato allora ritorna semplicemente false.
      def core_getApplicationLoginRoot
        return CORE_APPLOGINROOT if defined? CORE_APPLOGINROOT
        directory = core_getCacheDirectory
        if File.exist? "#{directory}/config.yml"
          config = YAML.load(
            File.read(File.expand_path("#{directory}/config.yml", __FILE__))
          )
          return config['login_home'] if config && config['login_home']
        else
          return false
        end
      end

      # Ritorna l'url del logo custom da applicare alla applicazione Lato.
      # Se non e' stato caricato alcun logo allora ritorna false
      def core_getApplicationLogo
        return CORE_APPLOGO if defined? CORE_APPLOGO
        directory = core_getCacheDirectory
        if File.exist? "#{directory}/logo.svg"
          return File.read("#{directory}/logo.svg")
        else
          return false
        end
      end

      # Ritorna il nome dell'applicazione principale settato nel file
      # config/lato/config.yml.
      # Se l'applicazione principale non specifica nessun nome allora
      # la funzione ritorna il valore 'Lato'
      def core_getApplicationName
        return CORE_APPNAME if defined? CORE_APPNAME
        directory = core_getCacheDirectory
        if File.exist? "#{directory}/config.yml"
          config = YAML.load(
            File.read(File.expand_path("#{directory}/config.yml", __FILE__))
          )
          if config && config['app_name']
            return config['app_name']
          else
            return 'Lato'
          end
        end
      end

      # Legge il file di configurazione e verifica se e' stato impostato un root url
      # per l'applicazione. Se non è stato impostato utilizza di default 'localhost'
      def core_getApplicationURL
        return CORE_APPURL if defined? CORE_APPURL
        directory = core_getCacheDirectory
        if File.exist? "#{directory}/config.yml"
          config = YAML.load(
            File.read(File.expand_path("#{directory}/config.yml", __FILE__))
          )
          if config && config['root_url']
            return config['root_url']
          else
            return 'http://localhost:3000'
          end
        end
      end

      # Legge il file di configurazione e verifica se è stato impostato un indirizzo
      # email di servizio. Se non e' stata impostata allora utilizza quella di
      # default 'service@lato.com'
      def core_getApplicationServiceEmail
        return CORE_APPSERVICEMAIL if defined? CORE_APPSERVICEMAIL
        directory = core_getCacheDirectory
        if File.exist? "#{directory}/config.yml"
          config = YAML.load(
            File.read(File.expand_path("#{directory}/config.yml", __FILE__))
          )
          if config && config['service_email']
            return config['service_email']
          else
            return 'service@lato.com'
          end
        end
      end

      # Esamina tutte le gemme della applicazione principale e ritorna
      # solamente quelle appartenenti al progetto Lato.
      # * *Returns* :
      # - array di stringhe con i nomi delle gemme del progetto Lato usate dall'applicazione
      def core_getLatoGems
        gems = core_getGems
        lato_gems = []
        # controllo ogni gemma
        gems.each do |name|
          lato_gems.push(name) if name.start_with? 'lato'
        end
        # ritorno il risultato
        lato_gems
      end

      # Ritorna la lista dei nomi delle gemme utilizzate dalla applicazione
      # principale
      # * *Returns* :
      # - array di stringhe con i nomi delle gemme dell'applicazione
      def core_getGems
        require 'bundler'
        Bundler.load.specs.map { |spec| spec.name }
      end

    end

  end
end
