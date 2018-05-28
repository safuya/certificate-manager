# frozen_string_literal: true

class LoadBalancer < ApplicationRecord
  has_many :certificates
  validates :hostname, uniqueness: true
  validates :hostname, presence: true
end
