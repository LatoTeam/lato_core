module LatoCore
  # This module contains functions for the communication with other modules.
  module Interface::Communication

    # This function return the login root set for the application (the url
    # where user is redirect after login).
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

    # This function return the application name.
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

    # This function return the application url set on the config file.
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

    # This function return the default service email set on the config file.
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

    # This function return the list of lato gems used by the application.
    def core_getLatoGems
      gems = core_getGems
      lato_gems = []
      # check every gem
      gems.each do |name|
        lato_gems.push(name) if name.start_with? 'lato'
      end
      # return result
      lato_gems
    end

    # This function return the list of gems used by the application.
    def core_getGems
      require 'bundler'
      Bundler.load.specs.map { |spec| spec.name }
    end

  end
end
