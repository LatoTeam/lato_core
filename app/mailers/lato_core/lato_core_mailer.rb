module LatoCore
  class LatoCoreMailer < ApplicationMailer
  	
  	def recover_user_password_email(user, code)
  	  @user = user
  	  @code  = code
  	  mail(to: @user.email, subject: "Recover now your email for #{core_getApplicationName}")
  	end

  end
end
