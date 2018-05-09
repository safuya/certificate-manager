class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true

  def self.find_or_create_by_omniauth(auth)
    where(username: auth[:info][:nickname]).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
end
