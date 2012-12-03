class PagesController < ApplicationController
  
  def home
    
  end
  
  def rewards
    
    @client = Twitter::Client.new(
      :consumer_key => ENV['consumer_key'],
      :consumer_secret => ENV['consumer_secret'],
      :oauth_token => session[:token],
      :oauth_token_secret => session[:secret]
    )
        
    # Twitter.configure do |config|
    #   config.consumer_key = ENV['consumer_key']
    #   config.consumer_secret = ENV['consumer_secret']
    #   config.oauth_token = session[:token]
    #   config.oauth_token_secret = session[:secret]
    # end
    
    tweets = Array.new()
    @client.mentions_timeline.each do |tweet|
      if tweet[:text].include?('#potofgold')
        user = tweet[:user][:id]
        @client.direct_message_create(user, "Congrats! Enjoy your reward #{root_url}pot_of_gold")
      end
    end
    
    redirect_to root_url
    
  end
  
  def pot_of_gold
    
  end

end