class LoadBalancer < ApplicationRecord
  validates :hostname, :ip_address, uniqueness: true
end
