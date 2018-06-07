# frozen_string_literal: true

module AuthenticationHelper
  def authenticate!
    unless logged_in?
      redirect_to root_url, alert: 'Only authorised users can see that content'
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
