# frozen_string_literal: true

class CertificateCiphersController < ApplicationController
  before_action :authenticate!

  def index
    @certificate_ciphers = CertificateCipher.all
  end

  def update
    certificate_cipher = CertificateCipher.find(params[:id])
    certificate_cipher.update(certificate_cipher_params)
    redirect_to certificate_ciphers_url
  end

  private

  def certificate_cipher_params
    params.require(:certificate_cipher).permit(:comment)
  end
end
