# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'login' do
  it 'submits a new authenticated username' do
    visit root_url

    fill_in :username, with: 'rob'
    fill_in :password, with: 'letmein'
    click_button :ENTER

    expect(page).to have_selector('h1', text: 'Certificates')
  end
end
