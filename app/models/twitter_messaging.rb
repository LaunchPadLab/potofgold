class TwitterMessaging
  
  def initialize(token, secret)
    @client = Twitter::Client.new(
      :consumer_key => ENV['consumer_key'],
      :consumer_secret => ENV['consumer_secret'],
      :oauth_token => token,
      :oauth_token_secret => secret
    )
  end
  
  def send_tweet(status)
    @client.update(status)
  end
  
end