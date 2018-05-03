# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])
    session[:user_id] = if user
                          user.id
                        else
                          user = User.new(username: params[:username])
                          user.save!
                          user.id
                        end
    redirect_to certificates_url
  end
end
