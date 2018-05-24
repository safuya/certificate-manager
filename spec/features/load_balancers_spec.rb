# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'load_balancers' do
  before do
    @user = User.create(username: 'rob', password: 'letmein')
    page.set_rack_session(user_id: @user.id)
  end

  it 'shows all of the certificates' do
    che_lb = LoadBalancer.create(hostname: 'stm01.che.room101.com',
                                 ip_address: '10.207.7.101')
    che_lb.certificates.create(url: 'awesome-site.com',
                               expiration: Date.iso8601('2016-07-03'),
                               ip_address: '123.123.123.123')
    LoadBalancer.create(hostname: 'stm01.vole.room101.com',
                        ip_address: '10.101.20.123')
    visit '/load_balancers'
    expect(page.body).to have_text('stm01.che.room101.com')
    expect(page.body).to have_text('awesome-site.com')
  end
end
