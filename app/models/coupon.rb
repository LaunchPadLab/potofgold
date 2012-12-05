class Coupon < ActiveRecord::Base
  attr_accessible :deal_id, :followers, :redeemed, :user_id
  
  #Scope
  scope :redeemed, where(redeemed: true)
  scope :for_user, lambda { |user_id| where(user_id: user_id) }
  #Instance Method
  
end