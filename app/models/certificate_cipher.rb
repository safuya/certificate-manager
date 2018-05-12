class CertificateCipher < ApplicationRecord
  belongs_to :certificate
  belongs_to :cipher
end
