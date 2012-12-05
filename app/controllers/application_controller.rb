require 'rails_extensions'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_authorized_user
  
  def current_authorized_user
    AuthorizedUser.current_authorized_user(session[:uid])
  end
  
end
