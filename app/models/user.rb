class User < ActiveRecord::Base
  attr_accessible :image_url, :uid, :username
  
  #Associations
  has_many :coupons
  
  #Class Method
  def self.find_or_create_from_auth_hash(auth_hash)
    user = self.find_by_uid(auth_hash['uid'])
    unless user
      user = self.create(image_url: auth_hash['info']['image'], uid: auth_hash['uid'], username: auth_hash['info']['nickname'])
    end
  end
  
end
