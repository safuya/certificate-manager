# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'add_certificates' do
  before do
    @user = User.create(username: 'rob', password: 'letmein')
  end

  it 'links to adding certificates on the certificates index' do
    page.set_rack_session(user_id: @user.id)
    visit '/certificates'
    click_link 'add-certificate'
    expect(page.body).to have_text('Add Certificate')
  end

  it 'lets you fill in all the credentials' do
    Cipher.create(name: 'TLA')
    page.set_rack_session(user_id: @user.id)
    visit '/certificates/new'
    fill_in :certificate_url, with: 'website.com'
    select '2019', from: :certificate_expiration_1i
    select 'January', from: :certificate_expiration_2i
    select '1', from: :certificate_expiration_3i
    fill_in :certificate_ip_address, with: '1.2.3.4'
    fill_in :certificate_load_balancer_hostname, with: 'lb01.room101.com'
    check :certificate_cipher_ids_1
    click_button 'submit-certificate'
    expect(page.current_url).to eql(certificates_url)
    expect(page.body).to have_text('website.com')
  end
end
