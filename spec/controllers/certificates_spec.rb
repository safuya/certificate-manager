# frozen_string_literal: true

require 'rails_helper'
require 'date'

RSpec.describe CertificatesController do
  before do
    @user = User.create(username: 'rob', password: 'letmein1')
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

  it 'lets you create a new certificate' do
    post :create,
         params: {
           certificate: {
             'url' => 'website.com',
             'expiration(1i)' => '2019',
             'expiration(2i)' => '1',
             'expiration(3i)' => '1',
             'ip_address' => '1.2.3.4',
             'load_balancer_hostname' => 'lb01.room101.com',
             'cipher_ids' => ['', '1']
           }
         },
         session: { user_id: @user.id }
    expect(Certificate.find_by(url: 'website.com'))
      .to respond_to(:vulnerabilities)
  end

  it 'deals with blank urls' do
    post :create,
         params: { certificate: { ip_address: '1.2.3.4' } },
         session: { user_id: @user.id }
    expect(flash[:error]).to eq("Url can't be blank")
  end
end
