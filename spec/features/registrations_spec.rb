# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'registration' do
  it 'lets a user signup' do
    visit 'users/new'
    fill_in :user_username, with: 'newbie'
    fill_in :user_password, with: 'P@ssw0rd'
    click_button 'register'
    expect(page.body).to have_text('Certificates')
  end
end
