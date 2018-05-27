class CertificateCipher < ApplicationRecord
  belongs_to :certificate
  belongs_to :cipher

  def certificate_url
    certificate.url
  end

  def cipher_name
    cipher.name
  end
end
