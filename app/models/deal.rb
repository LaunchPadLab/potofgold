class Deal < ActiveRecord::Base
  
  include Rails.application.routes.url_helpers
  
  attr_accessible :advertiser_id, :coupon_text, :end_date, :sample_tweet
  
  #Associations
  belongs_to :advertiser
  has_many :coupons
  has_many :users, through: :coupons
  
  #Instance methods
  def redemptions
    self.coupons.redeemed.length
  end
  
  def followers
    self.coupons.any? ? self.coupons.map { |c| c.followers }.total : 0
  end
  
  def conversion
    self.coupons.redeemed.length.to_f / self.coupons.length.to_f
  end
  
end
