# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { User.new(username: 'rob') }
  let(:duplicate_user) { User.new(username: 'rob') }

  it 'creates new users' do
    expect(user).to be_valid
  end

  it 'has a unique #username' do
    user.save
    expect(duplicate_user).to_not be_valid
  end
end
