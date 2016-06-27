# Includo l'interfaccia di lato_core
include LatoCore::Interface

module LatoCore
  # Classe base di gestione dei mailers
  class ApplicationMailer < ActionMailer::Base
    default from: core_getApplicationServiceEmail
    layout 'lato_core/mailers/layouts/mailer'
  end
end
