class SessionsController < ApplicationController
  def new; end

  def create
    user = User.new(username: params[:username])
    user.save!
    session[:id] = user.id
    redirect_to certificates_url
  end
end
