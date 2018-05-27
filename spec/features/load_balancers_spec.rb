# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'load_balancers' do
  before do
    @user = User.create(username: 'rob', password: 'letmein1')
    page.set_rack_session(user_id: @user.id)
    @che_lb = LoadBalancer.create(hostname: 'stm01.che.room101.com',
                                  ip_address: '10.207.7.101')
    @che_lb.certificates.create(url: 'awesome-site.com',
                                expiration: Date.iso8601('2016-07-03'),
                                ip_address: '123.123.123.123')
    LoadBalancer.create(hostname: 'stm01.vole.room101.com',
                        ip_address: '10.101.20.123')
  end

  it 'shows all of the load balancers' do
    visit '/load_balancers'
    expect(page.body).to have_text('stm01.che.room101.com')
    expect(page.body).to have_text('awesome-site.com')
  end

  it 'edits load balancers' do
    visit '/load_balancers'
    click_link "edit-#{@che_lb.id}"
    fill_in :load_balancer_hostname, with: 'stm01.hdr.room101.com'
    click_button 'submit'
    expect(page.body).to have_text('stm01.hdr.room101.com')
  end

  it 'edits nested resources' do
    visit "/load_balancers/#{@che_lb.id}/edit"
    click_link "edit-#{@che_lb.certificates[0].id}"
    fill_in :certificate_url, with: 'awesomesauce.com'
    click_button 'submit-certificate'
    expect(page.body).to have_text('awesomesauce.com')
  end

  it 'creates load balancers' do
    visit '/load_balancers'
    click_link 'new-load-balancer'
    fill_in :load_balancer_hostname, with: 'lb01.room101.com'
    fill_in :load_balancer_ip_address, with: '10.101.20.57'
    click_button 'submit'
  end
end
