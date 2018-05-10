# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  it 'renders the login page' do
    get :new
    expect(response).to render_template(:new)
  end

  it 'lets users sign in' do
    rob = User.create!(username: 'hughesr8', password: 'letmein')
    post :create, params: { username: 'hughesr8', password: 'letmein' }
    expect(session[:user_id]).to eql(rob.id)
  end

  it 'doesnt let invalid users sign in' do
    User.create!(username: 'hughesr8', password: 'letmein')
    post :create, params: { username: 'hughesr8', password: 'hacking' }
    expect(session.key?(:user_id)).to eql(false)
  end

  it 'logs users out' do
    rob = User.create!(username: 'hughesr8', password: 'letmein')
    delete :destroy, session: { user_id: rob.id }
    expect(response).to redirect_to root_path
    expect(session[:user_id]).to be(nil)
  end
end
