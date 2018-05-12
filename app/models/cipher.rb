class Cipher < ApplicationRecord
  has_many :certificate_ciphers
  has_many :certificates, through: :certificate_ciphers
end
