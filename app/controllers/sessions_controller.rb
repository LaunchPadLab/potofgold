class SessionsController < ApplicationController
  
  def create
    session[:token] = auth_hash['credentials']['token']
    session[:secret] = auth_hash['credentials']['secret']
    session[:user_name] = auth_hash['info']['nickname']
    session[:uid] = auth_hash['uid']
    if session[:deal_id]
      # @client = Twitter::Client.new(
      #   :consumer_key => ENV['consumer_key'],
      #   :consumer_secret => ENV['consumer_secret'],
      #   :oauth_token => session[:token],
      #   :oauth_token_secret => session[:secret]
      # )
      # @user = User.find_or_create_from_auth_hash(auth_hash)
      # @deal = Deal.find_by_id(session[:deal_id])
      # @user.coupons.create(deal_id: session[:deal_id], followers: @client.followers_count, redeemed: false)
      # @client.update(@deal.coupon_text)
      session[:deal_id] = nil
      # redirect_to deal_url(@deal)
      redirect_to root_url
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