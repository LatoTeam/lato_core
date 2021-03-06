module LatoCore
  class Back::SuperusersController < Back::BackController

    # before actions
    before_action do
      # set menu voice active
      view_setCurrentVoice('core_superusers')
      # check minimum permission value to 6
      redirect_to lato_core.root_path unless core_controlPermission(6)
    end

    def new
      @superuser = LatoCore::Superuser.new
    end

    def create
      superuser = LatoCore::Superuser.new(superuser_params)
      # controllo che l'utente creato non abbia permessi superiori dell'utente
      # creatore
      if superuser.permission > core_getCurrentUser.permission
        flash[:warning] = CORE_LANG['superusers']['permission_create']
        redirect_to lato_core.superusers_path and return false
      end
      # controllo che la creazione dell'utente non abbia avuto errori
      unless superuser.save
        flash[:danger] = CORE_LANG['superusers']['failed_create']
        redirect_to lato_core.superusers_path and return false
      end

      flash[:success] = CORE_LANG['superusers']['success_create']
      redirect_to lato_core.superuser_path(superuser)
    end

    def edit
      @superuser = LatoCore::Superuser.find(params[:id])
      # controllo che l'utente da modificare esista
      unless @superuser
        flash[:warning] = CORE_LANG['superusers']['not_found']
        redirect_to lato_core.superusers_path and return false
      end
      # controllo che l'utente da modificare non abbia permessi uguali o
      # maggiori dell'utente modificatore
      if @superuser.permission >= core_getCurrentUser.permission &&
         @superuser.permission != core_getCurrentUser.permission
        flash[:warning] = CORE_LANG['superusers']['permission_update']
        redirect_to lato_core.superusers_path and return false
      end
    end

    def update
      superuser = LatoCore::Superuser.find(params[:id])
      # controllo che l'utente da modificare esista
      unless superuser
        flash[:warning] = CORE_LANG['superusers']['not_found']
        redirect_to lato_core.superusers_path and return false
      end
      # controllo che l'utente da modificare non abbia permessi uguali o
      # maggiori dell'utente modificatore
      if superuser.permission >= core_getCurrentUser.permission &&
         superuser != core_getCurrentUser
        flash[:warning] = CORE_LANG['superusers']['permission_update']
        redirect_to lato_core.superusers_path and return false
      end
      # controllo che l'utente non si stia auto aumentando i permessi
      if superuser.id === core_getCurrentUser.id &&
         superuser.permission < params[:superuser][:permission].to_i
        flash[:warning] = CORE_LANG['superusers']['level_update']
        redirect_to lato_core.superusers_path and return false
      end
      # faccio in modo che l'aggiornamento avvenga senza problemi anche se
      # la password non e' stata inserita
      if params[:superuser][:password].blank? &&
         params[:superuser][:password_confirmation].blank?
        params[:superuser].delete(:password)
        params[:superuser].delete(:password_confirmation)
      end
      # controllo che non ci siano stati errori di aggiornamento
      unless superuser.update(superuser_params)
        flash[:danger] = CORE_LANG['superusers']['failed_update']
        redirect_to lato_core.superuser_path(superuser) and return false
      end

      flash[:success] = CORE_LANG['superusers']['success_update']
      redirect_to lato_core.superuser_path(superuser)
    end

    def destroy
      superuser = LatoCore::Superuser.find(params[:id])
      # controllo che l'utente da eliminare esista
      unless superuser
        flash[:warning] = CORE_LANG['superusers']['not_found']
        redirect_to lato_core.superusers_path and return false
      end
      # controllo che l'utente non stia provando a eliminare se stesso
      if superuser === core_getCurrentUser
        flash[:warning] = CORE_LANG['superusers']['itself_destroy']
        redirect_to lato_core.superusers_path and return false
      end
      # controllo che l'utente da eliminare non abbia permessi maggiori o
      # uguali all'utente eliminatore
      if superuser.permission >= core_getCurrentUser.permission
        flash[:warning] = CORE_LANG['superusers']['permission_destroy']
        redirect_to lato_core.superusers_path and return false
      end
      # controllo che non ci siano stati errori durante l'eliminazione
      unless superuser.destroy
        flash[:danger] = CORE_LANG['superusers']['failed_destroy']
        redirect_to lato_core.superuser_path(superuser) and return false
      end

      flash[:success] = CORE_LANG['superusers']['success_destroy']
      redirect_to lato_core.superusers_path
    end

    def show
      @superuser = LatoCore::Superuser.find(params[:id])
      # controllo che l'utente da mostrare sia esistente
      redirect_to lato_core.superusers_path unless @superuser
    end

    def index
      @search_superusers = LatoCore::Superuser.ransack(params[:q])
      # controllo che non vengano mostrati gli utenti impostati nascosti
      hide_settings = core_getHideUsersSettings
      if hide_settings && !hide_settings.blank?
        permissions_not_accepted = []
        current_user_permission = core_getCurrentUser.permission
        hide_settings.each do |setting|
          permissions_not_accepted.push(setting.first) if setting.last.to_i === current_user_permission
        end
        @superusers = @search_superusers.result.where.not(permission: permissions_not_accepted)
      else
        @superusers = @search_superusers.result
      end
      @superusers = @superusers.order(
        'username ASC'
      ).paginate(page: params[:page], per_page: 10)
    end

    # This function set default params accepted for user.
    private def superuser_params
      params.require(:superuser).permit(:name, :username, :email, :permission,
      :password, :password_digest)
    end

  end
end
