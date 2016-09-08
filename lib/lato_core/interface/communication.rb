module LatoCore
  module Interface::Communication

    # Return the relative url for main page after login.
    # * *Returns* :
    # - string of relative url to main page after login
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

    # Return the application name set on config file.
    # * *Returns* :
    # - string of application name set on config file
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

    # Return the application url set on configuration file. Return localhost:3000 if url is not
    # set.
    # * *Returns* :
    # - string of application url set on config file
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

    # Return the service email set on configuration file. Return 'service@lato.com' if
    # email is not set.
    # * *Returns* :
    # - string of service email set on config file
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

    # Return an array of strings with the name of all lato gems used on application.
    # * *Returns* :
    # - array of strings of names of lato gems on project
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

    # Return an array of strings with the name of all gems used on application.
    # * *Returns* :
    # - array of strings of names of gems on project
    def core_getGems
      require 'bundler'
      Bundler.load.specs.map { |spec| spec.name }
    end

  end
end
