# Includo l'interfaccia di lato_core
include LatoCore::Interface
# Includo l'interfaccia di lato_view
include LatoView::Interface

module LatoCore
  module Back
    # Classe che gestisce il pannello di backoffice del modulo
    class BackController < ApplicationController

      # Imposto layout di base dal lato_view
      layout 'lato_layout'

      # Attivo il controllo delle credenziali
      before_action :core_controlUser

      # Richiama la view della home del pannello di backoffice
      def home
        # rimando ad una pagina custom se è stato impostato da file di configurazione
        redirect_to login_root if login_root = core_getApplicationLoginRoot and login_root
      end

    end

  end
end
