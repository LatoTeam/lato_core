module LatoCore
  module Interface::Authentication

    # Check if user is logged. Redirect to login path if user is not logged.
    def core_controlUser
      redirect_to lato_core.login_path unless core_controlSession
    end

    # Return user logged activerecord object.
    # * *Returns* :
    # - user if session is correct
    # - nil if session not exist
    def core_getCurrentUser
      user = LatoCore::Superuser.find(session[:user])
      return user if session[:user] && session[:session_code] && user
    end

    # Check if user permission is equal or greater than param.
    # * *Params* :
    # - permission: integer value between 1 to 10
    # * *Returns* :
    # - true if user permission is equal or greater than param
    # - false if user permission is not equal or greater than param
    def core_controlPermission(permission)
      user = core_getCurrentUser
      user && user.permission >= permission
    end

  end
end
