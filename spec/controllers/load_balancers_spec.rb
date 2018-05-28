# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoadBalancersController do
  before do
    @user = User.create(username: 'rob', password: 'letmein1')
    @certificate = Certificate.create(url: 'site.com',
                                      expiration: Date.iso8601('2016-06-29'),
                                      ip_address: '123.123.123.123')
    @certificate.create_load_balancer(hostname: 'lb01.bteat.room101.com',
                                      ip_address: '10.101.20.5')
  end

  it 'stops unauthenticated users' do
    get :index
    expect(flash[:alert]).to eql('Only authorised user can see that content')
  end

  it 'valides new load balancer hostnames and IPs are unique' do
    post :create,
         params: {
           load_balancer: {
             hostname: 'lb01.bteat.room101.com', ip_address: '10.101.20.5'
           }
         },
         session: { user_id: @user.id }
    expect(flash[:error]).to eq('Hostname has already been taken')
  end
end
