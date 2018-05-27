# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'audit' do
  before do
    @user = User.create(username: 'rob', password: 'letmein1')
    page.set_rack_session(user_id: @user.id)
    certificate = Certificate.create(url: 'site.com')
    cipher = certificate.ciphers.create(name: 'TLA')
    @certificate_ciphers = CertificateCipher.find_by(
      certificate_id: certificate.id, cipher_id: cipher.id
    )
  end

  it 'allows comments on certificate_cipher relations' do
    visit '/certificate_ciphers'
    fill_in "certificate_cipher_comment_#{@certificate_ciphers.id}",
            with: 'Test comment'
    click_button "submit_#{@certificate_ciphers.id}"
    expect(page.body).to have_selector("input[value='Test comment']")
  end
end
