# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController do
  it 'renders the login page' do
    get :new
    expect(response).to render_template(:new)
  end

  it 'lets users sign in' do
    rob = User.create!(username: 'hughesr8', password: 'letmein1')
    post :create, params: { username: 'hughesr8', password: 'letmein1' }
    expect(session[:user_id]).to eql(rob.id)
  end

  it 'doesnt let invalid users sign in' do
    User.create!(username: 'hughesr8', password: 'letmein1')
    post :create, params: { username: 'hughesr8', password: 'hacking' }
    expect(session.key?(:user_id)).to eql(false)
  end

  it 'logs users out' do
    rob = User.create!(username: 'hughesr8', password: 'letmein1')
    delete :destroy, session: { user_id: rob.id }
    expect(response).to redirect_to root_path
    expect(session[:user_id]).to be(nil)
  end

  it 'stops invalid users and flashes them' do
    post :create, params: { username: 'im_bad', password: 'letmein1' }
    expect(flash[:error]).to eq('Invalid username or password')
    expect(response).to redirect_to root_url
    expect(session[:user_id]).to be(nil)
  end
end
