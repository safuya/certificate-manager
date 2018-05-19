# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to certificates_url if logged_in?
  end

  def create
    if auth
      user = User.find_or_create_by_omniauth(auth)
    else
      user = User.find_by(username: params[:username])
      return head(:forbidden) unless user.authenticate(params[:password])
    end
    session[:user_id] = user.id
    redirect_to certificates_url
  end

  def destroy
    session.clear
    redirect_to root_url
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
