class Coupon < ActiveRecord::Base
  attr_accessible :deal_id, :followers, :redeemed, :user_id, :referred
  
  #Association
  belongs_to :user
  belongs_to :deal
  
  #Scope
  scope :redeemed, where(redeemed: true)
  scope :for_user, lambda { |user_id| where(user_id: user_id) }
  scope :referrals, where(referred: true)
  
  #Instance Method
  def not_redeemed?
    !self.redeemed
  end
  
  
end
