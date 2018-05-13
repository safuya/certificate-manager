# frozen_string_literal: true

class Certificate < ApplicationRecord
  belongs_to :load_balancer, optional: true
  has_many :certificate_ciphers
  has_many :ciphers, through: :certificate_ciphers

  def self.search(params)
    if search_filter?('vulnerabilities', params)
      vulnerabilities_search(params[:search])
    elsif search_filter?('ciphers', params)
      ciphers_search(params[:search])
    elsif search_filter?('ip_address', params)
      where('ip_address like ?', "%#{params[:search]}%")
    elsif search_filter?('load_balancer', params)
      load_balancer_search(params[:search])
    elsif params[:search]
      where('url like ?', "%#{params[:search]}%")
    else
      all
    end
  end

  def self.search_filter?(filter, params)
    params[:search] && params[:filter] == filter
  end

  def self.vulnerabilities_search(search_term)
    all.select { |cert| cert.vulnerabilities[0].include?(search_term) }
  end

  def self.ciphers_search(search_term)
    "Searching for #{search_term}"
  end

  def self.load_balancer_search(search_term)
    joins(:load_balancer).where('load_balancer.hostname like ?', search_term)
  end

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
