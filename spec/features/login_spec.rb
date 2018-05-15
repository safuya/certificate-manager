# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'login' do
  it 'lets a user login using local credentials' do
    User.create(username: 'rob', password: 'letmein')
    visit root_url

    fill_in :username, with: 'rob'
    fill_in :password, with: 'letmein'
    click_button :ENTER

    expect(page).to have_selector('h1', text: 'Certificates')
    expect(page).to have_link('rob')
  end

  it 'lets a user login using github' do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    visit root_url
    click_link 'github'
    expect(page).to have_link('mockuser')
    Rails.application.env_config['omniauth.auth'] = nil
  end
end
