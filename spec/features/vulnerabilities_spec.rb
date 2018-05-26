# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'vulnerabilities' do
  before do
    @awesome_site = Certificate.create(url: 'awesome-site.com',
                                       expiration: Date.iso8601('2016-07-03'),
                                       ip_address: '123.123.123.123')
    @awesome_site.ciphers.create(name: 'DES', secure: false)
    @awesome_site.ciphers.create(name: '3DES', secure: false)
    @awesome_site.ciphers.create(name: 'SHA-1', secure: true)
    @awesome_site.create_load_balancer(hostname: 'stm01.che.room101.com',
                                       ip_address: '10.207.7.123')
    @other_site = Certificate.create(
      url: 'other-place.com',
      expiration: Date.tomorrow,
      ip_address: '1.2.3.4'
    )
    @other_site.load_balancer = LoadBalancer.find_by(
      hostname: 'stm01.che.room101.com'
    )
    @user = User.create(username: 'rob', password: 'letmein1')
    @other_site.save
  end

  it 'lists out all of the certificates with their vulnerabilities' do
    page.set_rack_session(user_id: @user.id)
    visit '/certificates'
    within 'table' do
      expect(page.body).to have_text(@awesome_site.url)
      expect(page.body).to have_text(@other_site.url)
    end
  end

  it 'can search for vulnerabilities' do
    page.set_rack_session(user_id: @user.id)
    visit '/certificates'
    fill_in :search, with: 'awesome-site.com'
    fill_in :filter, with: 'url'
    click_button 'submit-search'
    within 'table' do
      expect(page.body).to have_text(@awesome_site.url)
      expect(page.body).not_to have_text(@other_site.url)
    end
  end
end
