module LatoCore
  class Engine < ::Rails::Engine
    isolate_namespace LatoCore

    # Add migration support
    initializer 'Add migration support' do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end

    # Add routes support
    initializer 'Add gem routes to application',
                before: :load_config_initializers do
      Rails.application.routes.append do
        mount LatoCore::Engine, at: '/lato/core'
      end
    end

    # Add interface to main application
    config.autoload_paths << LatoCore::Engine.root.join('lib/interface')

  end
end
