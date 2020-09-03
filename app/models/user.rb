class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  devise :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  validates :username,
            presence: true,
            length: { minimum: 5, maximum: 128 },
            format: { with: /\A[a-zA-Z0-9_]+\Z/ }

  def self.from_omniauth(auth)
    where(provider: auth.provider,
          uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.username = user.name.parameterize(separator: '_')[0..128]
      user.skip_confirmation!
    end
  end
end
