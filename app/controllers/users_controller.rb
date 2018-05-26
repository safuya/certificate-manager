# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to certificates_url
    else
      redirect_to new_users_url, flash: {
        error: 'Your username must be unique and you must provide a password'
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
