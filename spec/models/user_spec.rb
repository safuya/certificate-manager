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
end
