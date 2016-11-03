module LatoCore
  # This class is the model for superusers.
  class Superuser < ActiveRecord::Base

    # Validations
    ############################################################################

    validates :name, presence: true, length: { maximum: 50 }

    validates :username, presence: true, length: { maximum: 50 },
    uniqueness: { case_sensitive: false }

    validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }

    validates :permission, presence: true, length: { minimum: 1, maximum: 10 }

    validates :password, presence: true, length: { minimum: 6, maximum: 50 },  on: :create

    has_secure_password

    # Before db update
    ############################################################################

    before_create do
      username.downcase!
      email.downcase!
    end

    before_update do
      username.downcase!
      email.downcase!
    end

  end

end
