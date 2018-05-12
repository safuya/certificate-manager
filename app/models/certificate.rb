# frozen_string_literal: true

class Certificate < ApplicationRecord
  belongs_to :load_balancer, optional: true
  has_many :certificate_ciphers
  has_many :ciphers, through: :certificate_ciphers

  def load_balancer_hostname
    load_balancer&.hostname
  end

  def cipher_names
    ciphers.map(&:name)
  end

  def vulnerabilities
    result = expiration.past? ? ['Expired'] : []
    result += ciphers.reject(&:secure).map(&:name)
    result << 'All good!' if result.empty?
    result
  end
end
