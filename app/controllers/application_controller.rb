class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  helper_method :current_user, :logged_in?
  # allows us to use helper methods in our views, not just other controllers

  def login!(user)
    session[:session_token] = user.reset_session_token! 
    # ^ match up session's token to user's new token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user # makes true or false
  end

  def logout!
    @current_user.reset_session_token! # essentially logs out by unmatching tokens
    session[:session_token] = nil # get rid of old token
    @current_user = nil # clears instance variable
  end
  
end
