# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'certificates' do
  before do
    @user = User.create(username: 'rob', password: 'letmein1')
    @certificate = Certificate.create(url: 'site.com',
                                      expiration: Date.iso8601('2016-06-29'),
                                      ip_address: '123.123.123.123')
    page.set_rack_session(user_id: @user.id)
  end

  it 'links to adding certificates on the certificates index' do
    visit '/certificates'
    click_link 'add-certificate'
    expect(page.body).to have_text('Add Certificate')
  end

  it 'lets you fill in all the credentials' do
    Cipher.create(name: 'TLA')
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

  it 'deletes a certificate' do
    visit '/certificates'
    click_button "del-#{@certificate.id}"
    expect(page.current_url).to eql(certificates_url)
    expect(page.body).not_to have_text('site.com')
  end

  it 'edits a certificate' do
    visit '/certificates'
    click_link "edit-#{@certificate.id}"
    fill_in :certificate_load_balancer_hostname, with: 'lb01.room101.com'
    click_button 'submit-certificate'
    expect(page.current_url).to eql(certificates_url)
    expect(page.body).to have_text('lb01.room101.com')
  end
end
