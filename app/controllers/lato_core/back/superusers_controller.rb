module LatoCore
  module Back
    # Controller che gestisce il CRUD degli utenti amministratori
    class SuperusersController < Back::BackController
      # Imposto la voce di menu da attivare
      before_action :set_unique_name

      # Richiama la view di creazione di un nuovo utente con permessi di
      # accesso al pannello di backoffice
      def new
        @superuser = LatoCore::Superuser.new
      end

      # Crea un nuovo utente con permessi di accesso al pannello di backoffice
      # e rimanda alla pagina di visualizzazione del profilo utente appena
      # creato
      def create
        superuser = LatoCore::Superuser.new(superuser_params)
        # controllo che l'utente creato non abbia permessi superiori dell'utente
        # creatore
        if superuser.permission > core_getCurrentUser.permission
          flash[:warning] = CORE_LANG['superusers']['permission_create']
          redirect_to lato_core.superusers_path && return
        end
        # controllo che la creazione dell'utente non abbia avuto errori
        unless superuser.save
          flash[:danger] = CORE_LANG['superusers']['failed_create']
          redirect_to lato_core.superusers_path && return
        end

        flash[:success] = CORE_LANG['superusers']['success_create']
        redirect_to lato_core.superuser_path(superuser)
      end

      # Richiama la view di modifica dell'utente con id uguale a quello ricevuto
      # come parametro
      def edit
        @superuser = LatoCore::Superuser.find(params[:id])
        # controllo che l'utente da modificare esista
        unless @superuser
          flash[:warning] = CORE_LANG['superusers']['not_found']
          redirect_to lato_core.superusers_path && return
        end
        # controllo che l'utente da modificare non abbia permessi uguali o
        # maggiori dell'utente modificatore
        if @superuser.permission >= core_getCurrentUser.permission &&
           @superuser.permission != core_getCurrentUser.permission
          flash[:warning] = CORE_LANG['superusers']['permission_update']
          redirect_to lato_core.superusers_path && return
        end
      end

      # Aggiorna l'utente con i dati ricevuti come parametro
      def update
        superuser = LatoCore::Superuser.find(params[:id])
        # controllo che l'utente da modificare esista
        unless superuser
          flash[:warning] = CORE_LANG['superusers']['not_found']
          redirect_to lato_core.superusers_path && return
        end
        # controllo che l'utente da modificare non abbia permessi uguali o
        # maggiori dell'utente modificatore
        if superuser.permission >= core_getCurrentUser.permission &&
           superuser != core_getCurrentUser
          flash[:warning] = CORE_LANG['superusers']['permission_update']
          redirect_to lato_core.superusers_path && return
        end
        # controllo che l'utente non si stia auto aumentando i permessi
        if superuser.id === core_getCurrentUser.id &&
           superuser.permission < params[:superuser][:permission].to_i
          flash[:warning] = CORE_LANG['superusers']['level_update']
          redirect_to lato_core.superusers_path && return
        end
        # faccio in modo che l'aggiornamento avvenga senza problemi anche se
        # la password non è stata inserita
        if params[:superuser][:password].blank? &&
           params[:superuser][:password_confirmation].blank?
          params[:superuser].delete(:password)
          params[:superuser].delete(:password_confirmation)
        end
        # controllo che non ci siano stati errori di aggiornamento
        unless superuser.update(superuser_params)
          flash[:danger] = CORE_LANG['superusers']['failed_update']
          redirect_to lato_core.superuser_path(superuser) && return
        end

        flash[:success] = CORE_LANG['superusers']['success_update']
        redirect_to lato_core.superuser_path(superuser)
      end

      # Elimina l'utente con id ricevuto come parametro
      def destroy
        superuser = LatoCore::Superuser.find(params[:id])
        # controllo che l'utente da eliminare esista
        unless superuser
          flash[:warning] = CORE_LANG['superusers']['not_found']
          redirect_to lato_core.superusers_path && return
        end
        # controllo che l'utente non stia provando a eliminare se stesso
        if superuser === core_getCurrentUser
          flash[:warning] = CORE_LANG['superusers']['itself_destroy']
          redirect_to lato_core.superusers_path && return
        end
        # controllo che l'utente da eliminare non abbia permessi maggiori o
        # uguali all'utente eliminatore
        if superuser.permission >= core_getCurrentUser.permission
          flash[:warning] = CORE_LANG['superusers']['permission_destroy']
          redirect_to lato_core.superusers_path && return
        end
        # controllo che non ci siano stati errori durante l'eliminazione
        unless superuser.destroy
          flash[:danger] = CORE_LANG['superusers']['failed_destroy']
          redirect_to lato_core.superuser_path(superuser) && return
        end

        flash[:success] = CORE_LANG['superusers']['success_destroy']
        redirect_to lato_core.superusers_path
      end

      # Richiama la view per la visualizzazione di un singolo utente
      # con lo stesso id ricevuto come parametro
      def show
        @superuser = LatoCore::Superuser.find(params[:id])
        # controllo che l'utente da mostrare sia esistente
        redirect_to lato_core.superusers_path unless @superuser
      end

      # Richiama la view per la visualizzazione di tutti gli utenti
      # del sistema
      def index
        @search_superusers = LatoCore::Superuser.ransack(params[:q])
        @superusers = @search_superusers.result.paginate(page: params[:page], per_page: 1)
      end

      # Definisce i parametri accettati per le azioni di aggiornamento della
      # tabella superusers nel database
      private def superuser_params
        params.require(:superuser).permit(:name, :username, :email, :permission,
                                          :password, :password_digest)
      end

      # Imposta la voce della navbar degli utenti come attiva
      private def set_unique_name
        view_setCurrentVoice('core_superusers')
      end
      # Fine funzioni controller
    end
    # Fine controller Back::Superusers
  end
end
