class Coupon < ActiveRecord::Base
  attr_accessible :deal_id, :followers, :redeemed, :user_id, :referred, :tweet
  
  #Association
  belongs_to :user
  belongs_to :deal
  
  #Scope
  scope :redeemed, where(redeemed: true)
  scope :for_user, lambda { |user_id| where(user_id: user_id) }
  scope :referrals, where(referred: true)
  scope :oldest, order('created_at ASC')
  
  #Instance Method
  def not_redeemed?
    !self.redeemed
  end
  
  def expired?
    deal.end_date < DateTime.now()
  end
  
end
