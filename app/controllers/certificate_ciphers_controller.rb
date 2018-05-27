# frozen_string_literal: true

class CertificateCiphersController < ApplicationController
  before_action :authenticate!

  def index
    @certificate_ciphers = CertificateCipher.all
  end
end
