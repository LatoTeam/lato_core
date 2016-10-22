module LatoCore
  # This module contains functions used to get languages info.
  module Interface::Languages

    # This function return a boolean value to tells if applications has
    # languages set to config file.
    def core_applicationHasLanguages
      return (CORE_APPLANGUAGES.length > 1) if defined? CORE_APPLANGUAGES
      languages = core_getApplicationLanguages
      return languages.length > 1
    end

    # This function return an array of languages used by application.
    def core_getApplicationLanguages
      return CORE_APPLANGUAGES if defined? CORE_APPLANGUAGES
      languages = false
      if File.exist? "#{Rails.root}/config/lato/config.yml"
        config = YAML.load(
          File.read(File.expand_path("#{Rails.root}/config/lato/config.yml", __FILE__))
        )
        if config['languages']
          languages = config['languages'].split(',')

          languages.each do |language|
            language.downcase.delete(' ')
          end
        end
      end
      # return result
      return languages
    end

    # This function load and return the languages for a lato module.
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
