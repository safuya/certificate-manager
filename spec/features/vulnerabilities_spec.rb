# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'certificates' do
  before do
    @awesome_site = Certificate.create(
      url: 'awesome-site.com',
      expiration: Date.iso8601('2016-07-03'),
      ip_address: '123.123.123.123'
    )
    @awesome_site.ciphers.create(name: 'DES', secure: false)
    @awesome_site.ciphers.create(name: '3DES', secure: false)
    @awesome_site.ciphers.create(name: 'SHA-1', secure: true)
    @awesome_site.create_load_balancer(hostname: 'stm01.che.room101.com',
                                       ip_address: '10.207.7.123')
  end

  it 'lists out all of the certificates with their vulnerabilities' do
    visit '/certificates'
    within 'table' do
      expect(page.body).to have_text(@awesome_site.url)
    end
  end
end
