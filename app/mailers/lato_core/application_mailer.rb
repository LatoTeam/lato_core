module LatoCore
  # This class is the default class for mailers.
  class ApplicationMailer < ActionMailer::Base
    # set default email
    default from: core_getApplicationServiceEmail
    # set lato mailer layout
    layout 'lato_core/mailers/layouts/mailer'
  end
end
