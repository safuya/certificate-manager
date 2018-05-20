# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'delete_certificates' do
  before do
    @user = User.create(username: 'rob', password: 'letmein')
    @certificate = Certificate.create(url: 'site.com',
                                      expiration: Date.iso8601('2016-06-29'),
                                      ip_address: '123.123.123.123')
  end

  it 'deletes a certificate' do
    page.set_rack_session(user_id: @user.id)
    visit '/certificates'
    click_button "del-#{@certificate.id}"
    expect(page.current_url).to eql(certificates_url)
    expect(page.body).not_to have_text('site.com')
  end
end
