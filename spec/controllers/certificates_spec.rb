# frozen_string_literal: true

require 'rails_helper'
require 'date'

RSpec.describe CertificatesController do
  before do
    @user = User.create(username: 'rob', password: 'letmein')
    @certificate = Certificate.create(url: 'site.com',
                                      expiration: Date.iso8601('2016-06-29'),
                                      ip_address: '123.123.123.123')
    @certificate.ciphers.create(name: 'TLS_DHE_RSA_WITH_AES_128_CBC_SHA',
                                secure: true)
    @certificate.create_load_balancer(hostname: 'lb01.bteat.room101.com',
                                      ip_address: '10.101.20.5')
  end

  it 'provides all certificates' do
    get :index, session: { user_id: @user.id }
    expect(assigns(:certificates).first).to eql(@certificate)
  end

  it 'lets you search' do
    get :index,
        params: { search: 'site.com', filter: 'url' },
        session: { user_id: @user.id }
    expect(assigns(:certificates).first).to eql(@certificate)
  end
end
