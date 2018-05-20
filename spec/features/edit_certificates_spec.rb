# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'edit_certificates' do
  before do
    @user = User.create(username: 'rob', password: 'letmein')
    @certificate = Certificate.create(url: 'site.com',
                                      expiration: Date.iso8601('2016-06-29'),
                                      ip_address: '123.123.123.123')
  end

  it 'edits a certificate' do
    page.set_rack_session(user_id: @user.id)
    visit '/certificates'
    click_link "edit-#{@certificate.id}"
    fill_in :certificate_load_balancer_hostname, with: 'lb01.room101.com'
    click_button 'edit-certificate'
    expect(page.current_url).to eql(certificates_url)
    expect(page.body).to have_text('lb01.room101.com')
  end
end
