module LatoCore
  # Mailer utilizzato per la comunicazione con l'utente amministratore tramite email
  class SuperusersMailer < ApplicationMailer

    # Prende in input un utente, un titolo e un testo per notificare l'utente
    # con il messaggio richiesto
    def notify(user, title, message)
      # imposto i dati come variabili di classe
      @title = title
      @message = message
      # definisco oggetto email
      subject = "#{CORE_LANG['mailers']['notify_subject']} #{core_getApplicationName}"
      # invio l'email di notifica all'utente
      mail(to: user.email, subject: subject,
           template_path: 'lato_core/mailers/superusers')
    end

    # Prende in input un utente e un codice speciale.
    # Invia all'utente l'email per il recupero password contenente il codice speciale
    def recover_password(email, code_url)
      # identifico codice completo per l'utente
      @recover_url = core_getApplicationURL + lato_core.password_edit_path(code_url)
      # invio l'email all'utente
  	  mail(to: email, subject: CORE_LANG['recover_password']['email_subject'],
           template_path: 'lato_core/mailers/superusers')
    end

  end
end
