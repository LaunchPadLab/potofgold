require 'rails_extensions'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_advertiser
  helper_method :current_user
  
  def current_advertiser
    Advertiser.find_by_uid(session[:uid])
  end
  
  def current_user
    User.find_by_uid(session[:uid])
  end
  
end
