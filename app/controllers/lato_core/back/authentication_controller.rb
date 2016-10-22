module LatoCore
  module Back
    # This class is used for authentication actions.
    class AuthenticationController < Back::BackController

      # not use login check for actions on this controller.
      skip_before_action :core_controlUser, except: [:exec_logout]

      # This function render login view if user is not logged.
      def login
        redirect_to lato_core.root_path if core_controlSession
      end

      # This function exec the login for user using username and password.
      def exec_login
        if core_createSession(params[:username], params[:password])
          redirect_to lato_core.root_path
        else
          flash[:warning] = CORE_LANG['superusers']['login_error']
          redirect_to lato_core.login_path
        end
      end

      # This function exec the logout for user and redirect it to login page.
      def exec_logout
        core_destroySession
        redirect_to lato_core.login_path
      end

      # This function render the password forget view if user active this
      # action on config file.
      def password_forget
        redirect_to lato_core.root_path unless core_getRecoveryPasswordPermission
        redirect_to lato_core.root_path if core_controlSession
      end

      # This function exec the recover password action and send the email to
      # user for new password.
      def password_recover
        redirect_to lato_core.root_path unless core_getRecoveryPasswordPermission
        if user = LatoCore::Superuser.find_by(email: params[:email].downcase)
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

      # This function render the edit view for user who ask to recover
      # its password (and check if it can do this action).
      def password_edit
        redirect_to lato_core.root_path unless core_getRecoveryPasswordPermission
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

      # This function ecec the password update after the recovery request.
      def password_update
        redirect_to lato_core.root_path unless core_getRecoveryPasswordPermission
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
