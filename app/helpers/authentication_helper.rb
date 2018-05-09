# frozen_string_literal: true

module AuthenticationHelper
  def authenticate!
    redirect_to root_url unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
