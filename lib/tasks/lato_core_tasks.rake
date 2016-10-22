include LatoCore

# Initialize module on project
desc 'Create config.yml file for Lato configuration'
task :lato_core_initialize do
  directory = core_getCacheDirectory
  FileUtils.cp "#{LatoCore::Engine.root}/config/example.yml", "#{Rails.root}/config/lato/config.yml"
end
