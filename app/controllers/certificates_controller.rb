class CertificatesController < ApplicationController
  before_action :authenticate!

  def index
    @certificates = Certificate.search(params)
  end
end
