# frozen_string_literal: true

require 'rails_helper'
require 'date'

RSpec.describe CertificatesController do
  before do
    @user = User.create(username: 'rob', password: 'letmein')
    load_balancer = LoadBalancer.create(hostname: 'lb01.bteat.room101.com',
                                        ip_address: '10.101.20.5')
    @certificate = Certificate.create(url: 'site.com',
                                      expiration: Date.iso8601('2016-06-29'),
                                      load_balancer_id: load_balancer.id,
                                      ip_address: '123.123.123.123')
    cipher = Cipher.create(name: 'TLS_DHE_RSA_WITH_AES_128_CBC_SHA',
                           secure: true,
                           certificate_ids: [@certificate.id])
  end

  it 'provides all certificates' do
    get :index, session: { user_id: @user.id }
    expect(assigns(:certificates)).to eql([@certificate])
  end
end
