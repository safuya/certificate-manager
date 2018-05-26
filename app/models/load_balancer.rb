# frozen_string_literal: true

class LoadBalancer < ApplicationRecord
  has_many :certificates
  validates :hostname, :ip_address, uniqueness: true
end
