module LatoCore
  # L'interfaccia contiene un insieme di funzioni utilizzabili in maniera
  # universale dall'applicazione principale o da alti moduli
  module Interface

    # Azioni principali per la gestione della cache
    require 'lato_core/interface/cache'
    include LatoCore::Interface::Cache
    # Azioni principali per la gestione delle comunicazioni
    require 'lato_core/interface/communication'
    include LatoCore::Interface::Communication
    # Azioni principali per la gestione delle sessioni
    require 'lato_core/interface/session'
    include LatoCore::Interface::Session
    # Azioni principali per la gestione della navigazione
    require 'lato_core/interface/navigation'
    include LatoCore::Interface::Navigation
    # Azioni principali per la gestione degli assets
    require 'lato_core/interface/assets'
    include LatoCore::Interface::Assets
    # Azioni principali per il controllo dell'autenticazione
    require 'lato_core/interface/authentication'
    include LatoCore::Interface::Authentication
    # Azioni principali per la gestione delle lingue
    require 'lato_core/interface/languages'
    include LatoCore::Interface::Languages
    # Azioni principali per la gestione delle impostazioni superusers
    require 'lato_core/interface/superusers'
    include LatoCore::Interface::Superusers
    
  end
end
