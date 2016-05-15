include LatoCore::Interface
# Task che genera il file di configurazione di Lato nella cache
# dell'applicazione principale
desc 'Create config.yml file for Lato configuration'
task :lato_create_config_file do
  require 'yaml'
  # determino la directory di cache
  directory = core_getCacheDirectory
  config = {}
  # riempio il file di configurazione
  config['app_name'] = 'Lato'
  config['menu'] = {}
  config['menu']['example'] = {}
  config['menu']['example']['name'] = 'Menu voice'
  config['menu']['example']['url'] = '/'
  config['menu']['example']['icon'] = ''
  config['menu']['example']['position'] = 1
  config['menu']['example']['permission'] = 0
  config['assets'] = {}
  config['assets']['style'] = {}
  config['assets']['style']['url'] = 'application'
  config['assets']['style']['type'] = 'css'
  config['assets']['code'] = {}
  config['assets']['code']['url'] = 'application'
  config['assets']['code']['type'] = 'js'
  config['languages'] = 'it, en'
  config['login_home'] = '/example'
  # creo il file di configurazione per lato
  File.open("#{directory}/config.yml", 'w') { |f| f.write config.to_yaml }
end
