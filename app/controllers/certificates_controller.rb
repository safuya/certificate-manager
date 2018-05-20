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

  def destroy
    Certificate.destroy(params[:id])
    redirect_to certificates_url
  end

  def edit
    @certificate = Certificate.find(params[:id])
    @load_balancers = LoadBalancer.all
    @ciphers = Cipher.all
  end

  def update
    certificate = Certificate.find(params[:id])
    certificate.update(certificate_params)
    redirect_to certificates_url
  end

  private

  def certificate_params
    params.require(:certificate).permit(:url, :expiration, :ip_address,
                                        :load_balancer_hostname, cipher_ids: [])
  end
end
