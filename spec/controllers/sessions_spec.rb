# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  it 'renders the login page' do
    get :new
    expect(response).to render_template(:new)
  end

  it 'lets new users login' do
    post :create, params: { username: 'newuser', password: 'letmein' }
    expect(session[:user_id]).not_to be(nil)
  end

  it 'lets exisiting users login' do
    rob = User.create!(username: 'hughesr8')
    post :create, params: { username: 'hughesr8', password: 'letmein' }
    expect(session[:user_id]).to eql(rob.id)
  end

  it 'logs users out' do
    rob = User.create!(username: 'hughesr8')
    delete :destroy, session: { user_id: rob.id }
    expect(response).to redirect_to root_path
    expect(session[:user_id]).to be(nil)
  end
end
