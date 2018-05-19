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
    page.set_rack_session(user_id: @user.id)
    visit '/certificates/new'
  end
end
