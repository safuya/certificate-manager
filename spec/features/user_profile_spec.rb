# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user_profile' do
  before do
    @user = User.create(username: 'rob', password: 'letmein1')
    page.set_rack_session(user_id: @user.id)
  end

  it 'shows a users profile' do
    visit '/'
    click_link 'profile-link'
    expect(page.body).to have_text(@user.username)
  end

  it 'edits a users profile' do
    visit "users/#{@user.id}"
    click_link 'update-profile'
    fill_in :user_username, with: 'robert'
    fill_in :user_current_password, with: 'letmein1'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'submit'
    expect(page.body).to have_text('robert')
  end
end
