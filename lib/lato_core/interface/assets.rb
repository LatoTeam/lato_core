module LatoCore
  module Interface
    # Insieme di funzioni che permettono di gestire l'autenticazione degli
    # utenti che vogliono accedere al backoffice
    module Assets

      # Funzione che ritorna un array contenente gli url relativi degli assets
      # da usare nel layout di lato
      def core_getAssetsItems
        return CORE_ASSETS if defined? CORE_ASSETS
        getLatoAssetsItems + getApplicationsAssetsItems
      end

      # Funzione che ritorna un array contenente gli url relativi degli assets
      # delle gemme lato da usare nel layout di lato
      private def getLatoAssetsItems
        # inizializzo la lista degli assets
        assets = []
        # identifico la lista di gemme del progetto Lato usate dalla
        # applicazione
        gems = core_getLatoGems
        # per ogni gemma estraggo i dati necessari a riempire la navbar
        gems.each do |name|
          module_name = name.camelize
          module_root = module_name.constantize::Engine.root
          next unless File.exist? "#{module_root}/config/config.yml"
          # accedo al config.yml
          config = YAML.load(
            File.read(File.expand_path("#{module_root}/config/config.yml",
                                       __FILE__))
          )
          # estraggo i dati dallo yaml
          data = getConfigAssets(config)
          # aggiungo i dati nella risposta
          data.each do |single_asset|
            assets.push(single_asset)
          end
        end
        # ritorno il risultato
        assets
      end

      # Funzione che ritorna un array contenente gli url relativi degli assets
      # della applicazione principale da usare nel layout di lato
      private def getApplicationsAssetsItems
        # inizializzo la lista delle voci della navbar
        assets = []

        if File.exist? "#{Rails.root}/config/lato/config.yml"
          # accedo al config.yml
          directory = core_getCacheDirectory
          config = YAML.load(
            File.read(File.expand_path("#{directory}/config.yml", __FILE__))
          )
          # estraggo i dati dallo yaml
          data = getConfigAssets(config)
          # aggiungo i dati nella risposta
          data.each do |single_asset|
            assets.push(single_asset)
          end
        end
        # ritorno il risultato
        assets
      end

      # Estrae i dati relativi agli assets dal file config.yml di una
      # applicazione controllando che la struttura del file sia corretta
      private def getConfigAssets(config)
        # inizializzo la lista di dati
        results = []
        # se il file e' formattato correttamente esamino ogni sua voce
        if config && config['assets']
          config['assets'].each do |voice|
            # estraggo i dati
            # unique_name = voice[0]
            name = voice[1]['name'].downcase
            type = voice[1]['type'].downcase
            # genero l'oggetto con le informazioni di output
            output_voice = {
              name: name,
              type: type
            }
            # aggiungo la voce al risultato
            results.push(output_voice)
          end
        end
        # ritorno il risultato
        results
      end

    end

  end
end
