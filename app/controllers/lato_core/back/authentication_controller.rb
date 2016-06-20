module LatoCore
  module Back
    # Controller che gestisce il login e il logout degli utenti
    class AuthenticationController < Back::BackController
      # Permette il recupero password
      skip_before_action :core_controlUser

      # Richiama la view della pagina di login
      def login
      end

      # Esegue il login e, se l'utente e' autenticato lo rimanda
      # alla homepage del backoffice
      def exec_login
        if core_createSession(params[:username], params[:password])
          redirect_to lato_core.root_path
        else
          redirect_to lato_core.login_path
        end
      end

      # Esegue il logout e rimanda alla pagina di login del backoffice
      def exec_logout
        core_destroySession
        redirect_to lato_core.login_path
      end
      



      #
      #  RECUPERO PASSWORD UTENTE
      #
        # Predispone i token e gestisce l'invio di una mail per il recupero di password
        def recover_password
          if core_recoverPassword(params[:email])
            flash[:success] = CORE_LANG['superusers']['password_recover_sent']
          else
            flash[:danger] = CORE_LANG['superusers']['not_found']
          end         
          redirect_to lato_core.login_path
        end

        #Form di recupero password
        def change_password_form
          user = LatoCore::Superuser.find_by(email: params[:email])
          if !user.nil? && user.session_code == params[:token]
          else
            redirect_to lato_core.login_path          
          end
        end

        #Esecuzione di cambio password
        def exec_change_password
          user = LatoCore::Superuser.find_by(email: params[:email])
          if !user.nil? && user.session_code == params[:token]
            code = SecureRandom.urlsafe_base64
            user.update_attribute('session_code', code)
            user.update(password: params[:password], password_confirmation: params[:password])
            user.save
            flash[:success] = CORE_LANG['superusers']['success_update']
            redirect_to lato_core.login_path 
          else
            flash[:danger] = CORE_LANG['superusers']['failed_update']
            redirect_to lato_core.login_path          
          end
        end
      #
      #  FINE RECUPERO PASSWORD UTENTE
      #

    end

  end
end
