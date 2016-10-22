module LatoCore
  # This module contains funtions used for the navigation inside the application.
  module Interface::Navigation

    # This function return an array with navbar voices.
    def core_getNavbarItems
      return CORE_NAVIGATION if defined? CORE_NAVIGATION
      getApplicationNavbarItems + getLatoNavbarItems
    end

    # This function return an array with lato navbar voices.
    private def getLatoNavbarItems
      # inizializzo la lista delle voci della navbar
      navbar_items = []
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
        data = getConfigNavbarData(config)
        # aggiungo i dati nella risposta
        data.each do |single_voice|
          navbar_items.push(single_voice)
        end
      end
      # ritorno il risultato
      navbar_items
    end

    # This function return an array with application navbar voices.
    private def getApplicationNavbarItems
      directory = core_getCacheDirectory
      # inizializzo la lista delle voci della navbar
      navbar_items = []

      if File.exist? "#{directory}/config.yml"
        # accedo al config.yml
        directory = core_getCacheDirectory
        config = YAML.load(
          File.read(File.expand_path("#{directory}/config.yml", __FILE__))
        )
        # estraggo i dati dallo yaml
        data = getConfigNavbarData(config)
        # aggiungo i dati nella risposta
        data.each do |single_voice|
          navbar_items.push(single_voice)
        end
      end
      # ritorno il risultato
      navbar_items
    end

    # This function read and return config datas about navbar from a config file.
    private def getConfigNavbarData(config)
      # inizializzo la lista di dati
      results = []
      # se il file e' formattato correttamente esamino ogni sua voce
      if config and config['menu']
        config['menu'].each do |voice|
          # estraggo i dati
          unique_name = voice[0]
          name = voice[1]['name'].capitalize
          url = voice[1]['url'].downcase
          icon = voice[1]['icon'].downcase
          position = voice[1]['position']
          permission = voice[1]['permission']
          # genero l'oggetto con le informazioni di output
          output_voice = {
            unique_name: unique_name,
            name: name,
            url:  url,
            icon: icon,
            position: position,
            permission: permission
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
