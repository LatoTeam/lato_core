module LatoCore
  module Interface
    # Insieme di funzioni che determinano e gestiscono le informazioni riguardo
    # alle lingue dell'applicazione tra le sezioni offerte dai moduli lato
    module Languages

      # Funzione che ritorna true se l'applicazione ha piu' lingue, false se
      # l'applicazione ha una singola lingua
      def core_applicationHasLanguages
        return (CORE_APPLANGUAGES.length > 1) if defined? CORE_APPLANGUAGES
        languages = core_getApplicationLanguages
        languages.length > 1
      end

      # Funzione che ritorna un array contenente le lingue gestite
      # dall'applicazione
      def core_getApplicationLanguages
        return CORE_APPLANGUAGES if defined? CORE_APPLANGUAGES
        # definisco variabile di ritorno
        languages = false
        if File.exist? "#{Rails.root}/config/lato/config.yml"
          # accedo al config.yml
          config = YAML.load(
            File.read(File.expand_path("#{Rails.root}/config/lato/config.yml",
                                       __FILE__))
          )
          if config['languages']
            languages = config['languages'].split(',')

            languages.each do |language|
              language.downcase.delete(' ')
            end
          end
        end
        # ritorno il risultato
        return languages
      end

      # Funzione che ritorna la lettura del file di lingua corretto per
      # il modulo il cui nome e' ricevuto come parametro
      def core_loadModuleLanguages(module_name)
        module_root = module_name.camelize.constantize::Engine.root
        application_lang = Rails.application.config.i18n.default_locale
        if File.exist? "#{module_root}/lang/#{application_lang}.yml"
          return YAML.load(
            File.read(File.expand_path("#{module_root}/lang/#{application_lang}.yml",
                                       __FILE__))
          )
        else
          return YAML.load(
            File.read(File.expand_path("#{module_root}/lang/default.yml",
                                       __FILE__))
          )
        end
      end

    end

  end
end
