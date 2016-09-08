module LatoCore
  module Interface

    # List of interface modules

    require 'lato_core/interface/cache'
    include LatoCore::Interface::Cache

    require 'lato_core/interface/communication'
    include LatoCore::Interface::Communication

    require 'lato_core/interface/session'
    include LatoCore::Interface::Session

    require 'lato_core/interface/navigation'
    include LatoCore::Interface::Navigation

    require 'lato_core/interface/authentication'
    include LatoCore::Interface::Authentication

    require 'lato_core/interface/languages'
    include LatoCore::Interface::Languages

    require 'lato_core/interface/superusers'
    include LatoCore::Interface::Superusers

  end
end
