# frozen_string_literal: true

class CertificatesController < ApplicationController
  before_action :authenticate!

  def index
    @certificates = Certificate.search(params)
  end

  def new
    @certificate = Certificate.new
    @load_balancers = LoadBalancer.all
    @ciphers = Cipher.all
  end

  def create
    Certificate.create(certificate_params)
    redirect_to certificates_url
  end

  private

  def certificate_params
    params.require(:certificate).permit(:url, :expiration, :ip_address,
                                        :load_balancer_hostname, cipher_ids: [])
  end
end
