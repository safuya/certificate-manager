class LoadBalancer < ApplicationRecord
  has_many :certificates
  validates :hostname, :ip_address, uniqueness: true
end
