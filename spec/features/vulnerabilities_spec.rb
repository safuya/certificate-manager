# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'certificates' do
  it 'lists out all of the certificates with their vulnerabilities' do
    awesome_site = {
      url: 'awesome-site.com',
      expiration: 'Oct 2015',
      environment: 'Headend',
      vulnerabilities: "Expired\nDES",
      ciphers: "DES\n3DES\nSHA-1",
      ip_address: '123.123.123.123',
      load_balancer: 'stm01.che.room101.com'
    }
    visit '/certificates'
    within 'table' do
      awesome_site.each do |_heading, text|
        expect(page.body).to have_text(text)
      end
    end
  end
end
