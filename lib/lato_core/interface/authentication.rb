module LatoCore
  module Interface
    # Insieme di funzioni che permettono di gestire l'autenticazione degli
    # utenti che vogliono accedere al backoffice
    module Authentication

      # Funzione che controlla se l'utente ha i permessi di accedere al
      # backoffice. Se l'utente non ha i permessi viene rimandato alla pagina di login.
      def core_controlUser
        redirect_to lato_core.login_path unless core_controlSession
      end

      # Funzione che ritorna l'oggetto utente loggato.
      # * *Returns* :
      # - user_id se la sessione dell'utente risulta valida
      # - false se la sessione non esiste o non e' valida
      def core_getCurrentUser
        user = LatoCore::Superuser.find(session[:user])
        return user if session[:user] && session[:session_code] && user
      end

      # Funzione che controlla se i permessi dell'utente sono superiori al
      # livello ricevuto come parametro
      # * *Returns* :
      # - true se la sessione dell'utente ha permessi maggiori o uguali del parametro ricevuto
      # - false se la sessione non esiste o non ha i permessi necessari
      def core_controlPermission(permission)
        user = core_getCurrentUser
        user && user.permission >= permission
      end

    end
  end
end
