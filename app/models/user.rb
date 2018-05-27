class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true
  validates :password, length: { minimum: 8 }

  def self.find_or_create_by_omniauth(auth)
    where(username: auth[:info][:nickname]).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end

  def self.find_and_authenticate(username, password)
    user = User.find_by(username: username)
    user = false unless user&.authenticate(password)
    user
  end

  def updateable?(params)
    authenticate(params[:current_password]) && passwords_match?(params)
  end

  def passwords_match?(params)
    params[:user][:password] == params[:password_confirmation]
  end
end
