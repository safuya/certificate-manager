# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate!, only: %i[show edit]
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to certificates_url
    else
      redirect_to new_user_url, flash: {
        error: 'Your username must be unique and you must provide a password'
      }
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(params[:id])
    if user.updateable?(params)
      user.update(user_params)
      redirect_to user_url(current_user.id)
    else
      redirect_to edit_user_url(current_user), error: 'Failed to update.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
