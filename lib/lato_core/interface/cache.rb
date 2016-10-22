module LatoCore
  # This module contains functions for cache information.
  module Interface::Cache

    # This function return a string with the path of cache directory on
    # main project.
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
