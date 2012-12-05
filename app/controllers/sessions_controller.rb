class SessionsController < ApplicationController
  
  def create
    session[:token] = auth_hash['credentials']['token']
    session[:secret] = auth_hash['credentials']['secret']
    session[:user_name] = auth_hash['info']['nickname']
    session[:uid] = auth_hash['uid']
    if session[:deal_id]
      @user = User.find_or_create_from_auth_hash(auth_hash)
      @deal = Deal.find_by_id(session[:deal_id])
      @user.coupons.create(deal_id: @deal.id, followers: auth_hash['extra']['raw_info']['followers_count'], redeemed: false)
      TwitterMessaging.new(session[:token], session[:secret]).send_tweet(@deal.coupon_text)
      session[:deal_id] = nil
      redirect_to deal_url(@deal)
    else
      @advertiser = Advertiser.find_or_create_from_auth_hash(auth_hash)
      redirect_to deals_url
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