class SessionsController < ApplicationController
  
  def create
    session[:token] = auth_hash['credentials']['token']
    session[:secret] = auth_hash['credentials']['secret']
    session[:user_name] = auth_hash['info']['nickname']
    session[:uid] = auth_hash['uid']
    if session[:deal_id]
      @user = User.find_or_create_from_auth_hash(auth_hash)
      @deal = Deal.find_by_id(session[:deal_id])
      redirect_to deal_url(@deal)
    else
      @advertiser = Advertiser.find_or_create_from_auth_hash(auth_hash)
      if @advertiser.deals.any?
        redirect_to deals_url
      else
        redirect_to new_deal_url
      end
    end
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