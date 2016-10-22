module LatoCore
  # This class is the main class for the lato backend panel.
  class Back::BackController < ApplicationController

    # set default lato_view layout
    layout 'lato_layout'

    # set check login control for every actions.
    before_action :core_controlUser

    # This function render the default home view for lato after login or
    # redirect to custom url if config file set one.
    def home
      # rimando ad una pagina custom se è stato impostato da file di
      # configurazione
      if login_root = core_getApplicationLoginRoot and login_root
        redirect_to login_root
      end
    end

  end
end
