# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to certificates_url if logged_in?
  end

  def create
    user = if auth
             User.find_or_create_by_omniauth(auth)
           else
             User.find_and_authenticate(params[:username], params[:password])
           end
    if user
      session[:user_id] = user.id
      redirect_to certificates_url
    else
      redirect_to root_url, flash: { error: 'Invalid username or password' }
    end
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
