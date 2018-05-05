# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])
    user ||= User.create!(username: params[:username])
    session[:user_id] = user.id
    redirect_to certificates_url
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end
