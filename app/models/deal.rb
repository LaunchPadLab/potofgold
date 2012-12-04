class Deal < ActiveRecord::Base
  
  include Rails.application.routes.url_helpers
  
  attr_accessible :advertiser_id, :coupon_text, :end_date, :sample_tweet
  
  #Associations
  belongs_to :advertiser
  has_many :coupons
  
  #Model Callback
  after_create :update_deal_url
  
  def update_deal_url
    self.coupon_text += " http://potofgold.herokuapp.com/deals/#{self.id}"
    self.save
  end
  
  #Instance methods
  def redemptions
    self.coupons.redeemed.length
  end
  
  def followers
    self.coupons.any? ? self.coupons.map { |c| c.followers }.total : 0
  end
  
end
