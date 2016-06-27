module LatoCore
  module Back
    # Controller che gestisce il login e il logout degli utenti
    class AuthenticationController < Back::BackController

      # Disattivo il controllo dell'autenticazione utente
      skip_before_action :core_controlUser, except: [:exec_logout]

      # Richiama la view della pagina di login
      def login
        redirect_to lato_core.root_path if core_controlSession
      end

      # Esegue il login e, se l'utente e' autenticato lo rimanda
      # alla homepage del backoffice
      def exec_login
        if core_createSession(params[:username], params[:password])
          redirect_to lato_core.root_path
        else
          flash[:warning] = CORE_LANG['superusers']['login_error']
          redirect_to lato_core.login_path
        end
      end

      # Esegue il logout e rimanda alla pagina di login del backoffice
      def exec_logout
        core_destroySession
        redirect_to lato_core.login_path
      end

      # Richiama la view per la richiesta di una nuova password nel caso di
      # password dimenticata
      def password_forget
        redirect_to lato_core.root_path if core_controlSession
      end

      # Esegue il necessario per il recupero password e invia l'email al richiedente
      def password_recover
        if user = LatoCore::Superuser.find_by(email: params[:email])
          # genero il codice da salvare come session code
          code = "RECPSW-#{SecureRandom.urlsafe_base64}"
          # genero il codice per formare l'url di recupero password
          code_url = URI.encode("#{user.id}::#{Time.now}::#{code}")
          # memorizzo il session_code sul db
          user.update_attribute(:session_code, code)
          # invio una mail di recupero
          LatoCore::SuperusersMailer.recover_password(user.email, code_url).deliver_now
          flash[:success] = CORE_LANG['recover_password']['confirm_send']
        else
          flash[:warning] = CORE_LANG['superusers']['not_found']
        end
        redirect_to lato_core.login_path
      end

      # Richiama la view con il form per l'inserimento di una nuova password
      def password_edit
        redirect_to lato_core.root_path if core_controlSession
        # splitto il token ricevuto (formato: id utente, timestamp, session_code)
        data = URI.decode(params[:token]).split('::')
        # controllo che il formato sia corretto
        if data.length != 3
          flash[:warning] = CORE_LANG['recover_password']['recover_error_token']
          redirect_to lato_core.login_path and return false
        end
        # identifico i singoli dati
        user_id = data.first
        timestamp = data.second
        session_code = data.last
        # cerco l'utente e, se non esiste, stampo un errore
        @user = LatoCore::Superuser.find(user_id)
        if !@user
          flash[:warning] = CORE_LANG['recover_password']['recover_error_user']
          redirect_to lato_core.login_path and return false
        end
        # verifico che il token sia ancora valido e non abbia superato le 24 ore
        if !time = timestamp.to_time || time < Time.now - 24.hours
          flash[:warning] = CORE_LANG['recover_password']['recover_error_token_time']
          redirect_to lato_core.login_path and return false
        end
        # verifico che il session_code del token sia corretto
        if @user.session_code != session_code
          flash[:warning] = CORE_LANG['recover_password']['recover_error_token']
          redirect_to lato_core.login_path and return false
        end
        # genero un nuovo token per togliere la validita' al link di recupero password
        # e lo memorizzo all'utente
        new_code = SecureRandom.urlsafe_base64
        @user.update_attribute(:session_code, new_code)
      end

      # Aggiorna la password dell'utente che ha richiesto il recupero password
      def password_update
        user = LatoCore::Superuser.find(params[:id])
        if !user || user.session_code != params[:token]
          flash[:warning] = CORE_LANG['recover_password']['recover_error']
          redirect_to lato_core.login_path and return false
        end
        user.update(password: params[:password], password_confirmation: params[:password])
        if !user.save
          flash[:warning] = CORE_LANG['recover_password']['recover_error']
          redirect_to lato_core.login_path and return false
        end

        flash[:success] = CORE_LANG['recover_password']['recover_success']
        redirect_to lato_core.login_path
      end

    end
  end
end
