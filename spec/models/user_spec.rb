# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { User.new(username: 'rob', password: 'letmein1') }
  let(:duplicate_user) { User.new(username: 'rob', password: 'anotherme') }

  it 'creates new users' do
    expect(user).to be_valid
  end

  it 'has a unique #username' do
    user.save
    expect(duplicate_user).to_not be_valid
  end

  it 'has a #password at least 8 characters long' do
    short_pass = User.new(username: 'short', password: 'sweet')
    expect(short_pass).to_not be_valid
  end

  it 'checks if it is #updateable?' do
    params = {
      user: { password: 'password' },
      current_password: 'letmein1',
      password_confirmation: 'password'
    }
    expect(user.updateable?(params)).to be true
  end

  it 'is not #updateable? if the current password is wrong' do
    params = {
      user: { password: 'password' },
      current_password: 'im-wrong',
      password_confirmation: 'password'
    }
    expect(user.updateable?(params)).to be false
  end

  it 'is not #updateable? if the password confirmation is wrong' do
    params = {
      user: { password: 'password' },
      current_password: 'letmein1',
      password_confirmation: 'psssword'
    }
    expect(user.updateable?(params)).to be false
  end
end
