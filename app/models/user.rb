class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :username,
            presence: true,
            length: { minimum: 5, maximum: 128 },
            format: { with: /\A[a-zA-Z0-9_]+\Z/ }
end
