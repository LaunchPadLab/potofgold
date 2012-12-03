class SessionsController < ApplicationController
  def create
    #@user = User.find_or_create_from_auth_hash(auth_hash)
    #self.current_user = @user
    puts auth_hash
    session[:token] = auth_hash['credentials']['token']
    session[:secret] = auth_hash['credentials']['secret']
    session[:user_name] = auth_hash['info']['nickname']
    session[:uid] = auth_hash['uid']
    redirect_to root_url
  end
  
  def destroy
    reset_session
    
    redirect_to root_url
    
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
  
end