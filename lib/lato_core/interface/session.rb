module LatoCore
  # This module contains functions used to get information about user session.
  module Interface::Session

    # This function create a new session for user with username and
    # password received as params.
    def core_createSession(username, password)
      user = LatoCore::Superuser.find_by(username: username)
      if user && user.authenticate(password)
        # genero un session_code
        code = SecureRandom.urlsafe_base64
        # memorizzo il session_code sul db
        user.update_attribute('session_code', code)
        # genero le sessioni
        session[:user] = user.id
        session[:session_code] = code
        # ritorno true
        return true
      else
        # ritorno false
        return false
      end
    end

    # This function destroy the current user session.
    def core_destroySession
      if session[:user] && session[:session_code]
        # determino l'utente della sessione
        user = LatoCore::Superuser.find(session[:user])
        # se l'utente esiste elimino il suo session_code dal db
        user.update_attribute('session_code', nil) if user
        # elimino le sessioni
        session[:user] = nil
        session[:session_code] = nil
        # ritorno true
        return true
      else
        # ritorno false
        return false
      end
    end

    # This function check if user session is valid.
    def core_controlSession
      user = LatoCore::Superuser.find(session[:user]) if session[:user]

      if user && session[:session_code] &&
         user.session_code === session[:session_code] &&
         !user.session_code.nil?
        return true
      else
        return false
      end
    end

  end
end
