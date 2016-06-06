module LatoCore
  # Modello che si riferisce agli utenti con accesso al pannello di amministrazione
  class Superuser < ActiveRecord::Base

    # Lista validazioni
    validates :name, presence: true, length: { maximum: 50 }

    validates :username, presence: true,
                         length: { maximum: 50 },
                         uniqueness: { case_sensitive: false }

    validates :email, presence: true,
                      length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }

    validates :permission, presence: true,
                           length: { minimum: 1, maximum: 10 }

    validates :password, presence: true,
                         length: { minimum: 6, maximum: 50 },
                         on: :create

    has_secure_password

    # Azioni prima del salvataggio
    before_save do
      username.downcase!
      email.downcase!

      set_admin_permission
    end

    # Funzione che imposta i permessi dell'utente amministratore al
    # massimo livello
    private def set_admin_permission
      first_user = LatoCore::Superuser.first
      self.permission = 10 if first_user && id === first_user.id
    end

  end

end
