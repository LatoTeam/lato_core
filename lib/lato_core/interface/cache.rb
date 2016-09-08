module LatoCore
  module Interface::Cache

    # Create lato cache directory inside the project if they don't exist and
    # return the string of the path used as main cache for lato.
    # * *Returns* :
    # - string cache path
    def core_getCacheDirectory
      # directories for assets
      dirname = "#{Rails.root}/app/assets/images/lato"
      FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
      dirname = "#{Rails.root}/app/assets/stylesheets/lato"
      FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
      dirname = "#{Rails.root}/app/assets/javascripts/lato"
      FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
      # main cache directory
      dirname = "#{Rails.root}/config/lato"
      FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
      # return directory
      return dirname
    end

  end
end
