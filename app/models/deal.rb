class Deal < ActiveRecord::Base

  attr_accessible :advertiser_id, :coupon_text, :end_date, :sample_tweet, :description, :image_id
  
  #Associations
  belongs_to :advertiser
  has_many :coupons
  has_many :users, through: :coupons
  belongs_to :image
  
  #Validation
  validates :end_date, :coupon_text, :sample_tweet, :description, :image_id, presence: true
  
  #Instance methods
  def redemptions
    self.coupons.redeemed.length
  end
  
  def followers_array
    self.coupons.any? ? self.coupons.map { |c| c.followers } : [0]
  end
  
  def followers
    new_followers = self.coupons.any? ? self.coupons.map { |c| c.followers }.total : 0
    self.advertiser.followers_count + new_followers
  end
  
  def conversion
    self.coupons.length > 0 ? self.coupons.redeemed.length.to_f / self.coupons.length.to_f * 100.0 : 0
  end
  
  def expired?
    self.end_date < DateTime.now()
  end
  
  def not_expired?
    self.end_date >= DateTime.now()
  end
  
  def referrals
    self.coupons.referrals.length
  end
  
end
