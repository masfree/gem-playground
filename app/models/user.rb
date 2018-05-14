class User < ApplicationRecord
  has_many :authorization
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, omniauth_providers: [:vkontakte]

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    user = self.create_user(auth)

    user.create_authorization(auth)
    user
  end

  def create_authorization(auth)
    self.authorization.create!(provider: auth.provider, uid: auth.uid.to_s)
  end

  private

  def self.create_user(auth)
    email = "#{auth.uid}@#{auth.provider}.auth"
    password = Devise.friendly_token[0, 14]
    User.create!(email: email, password: password, password_confirmation: password)
  end
end
