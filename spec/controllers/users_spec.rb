# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  let(:error_message) do
    'Your username must be unique and you must provide a password'
  end

  it 'lets you create a user' do
    post :create, params: { user: { username: 'newbie', password: 'P@ssw0rd' } }
    expect(response).to redirect_to certificates_url
  end

  it 'stops two users with the same name' do
    2.times do
      post :create, params: {
        user: { username: 'newbie', password: 'P@ssw0rd' }
      }
    end
    expect(flash[:error]).to eq(error_message)
    expect(response).to redirect_to new_user_url
  end

  it 'stops passwords shorter than 8 characters' do
    post :create, params: { user: { username: 'short', password: 'sweet' } }
    expect(flash[:error]).to eq(error_message)
  end
end
