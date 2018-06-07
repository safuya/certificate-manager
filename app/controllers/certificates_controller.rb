# frozen_string_literal: true

class CertificatesController < ApplicationController
  before_action :authenticate!

  def index
    @certificates = Certificate.search(params)
  end

  def new
    @certificate = Certificate.new(load_balancer_id: params[:load_balancer_id])
    @load_balancers = LoadBalancer.all
    @ciphers = Cipher.all
  end

  def create
    @certificate = Certificate.new(certificate_params)
    if @certificate.save
      redirect_to certificates_url
    else
      flash[:error] = @certificate.errors.full_messages.to_sentence
      @load_balancers = LoadBalancer.all
      @ciphers = Cipher.all
      render :new
    end
  end

  def destroy
    certificate = Certificate.find(params[:id])
    certificate.certificate_ciphers.destroy_all
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
    params.require(:certificate).permit(
      :url, :expiration, :ip_address, :load_balancer_hostname, cipher_ids: []
    )
  end
end
