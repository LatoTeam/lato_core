module LatoCore
  module Interface::Languages

    # Return true if application has more than one language on config file.
    # * *Returns* :
    # - boolean value to say if application has more than one language
    def core_applicationHasLanguages
      return (CORE_APPLANGUAGES.length > 1) if defined? CORE_APPLANGUAGES
      languages = core_getApplicationLanguages
      return languages.length > 1
    end

    # Return an array of string with languages of application set on config file.
    # * *Returns* :
    # - array of string if application has languages on config file
    # - false if application has not languages on config files
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

    # Receive a string with the name of a lato module as params. Return the yaml file
    # result of the language of the application.
    # * *Params* :
    # - module_name: string with the name of a lato module used by the project
    # * *Returns* :
    # - hash of language file for the module
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
