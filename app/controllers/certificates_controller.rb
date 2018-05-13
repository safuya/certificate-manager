class CertificatesController < ApplicationController
  def index
    @certificates = Certificate.search(params)
  end
end
