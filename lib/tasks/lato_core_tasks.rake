include LatoCore::Interface

# Task che genera il file di configurazione di Lato nella cache
# dell'applicazione principale
desc 'Create config.yml file for Lato configuration'
task :lato_core_initialize do
  # determino la directory di cache
  directory = core_getCacheDirectory
  FileUtils.cp "#{LatoCore::Engine.root}/config/example.yml", "#{Rails.root}/config/lato/config.yml"

end
