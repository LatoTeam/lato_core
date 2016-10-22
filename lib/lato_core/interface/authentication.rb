module LatoCore
  # This module contains functions for authetication.
  module Interface::Authentication

    # This function check if user is logged and redirect to login path if
    # is not logged.
    def core_controlUser
      redirect_to lato_core.login_path unless core_controlSession
    end

    # This function search current user on database and return it if is
    # logged.
    def core_getCurrentUser
      user = LatoCore::Superuser.find(session[:user])
      return user if session[:user] && session[:session_code] && user
    end

    # This function control if current user has a permission level like
    # value set as params and return a boolean value.
    def core_controlPermission(permission)
      user = core_getCurrentUser
      user && user.permission >= permission
    end

  end
end
