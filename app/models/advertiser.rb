class Advertiser < ActiveRecord::Base
  attr_accessible :image_url, :uid, :username, :business_name
  
  #Associations
  has_many :deals
  has_many :images
  
  #Class Method
  def self.find_or_create_from_auth_hash(auth_hash)
    advertiser = self.find_by_uid(auth_hash['uid'])
    unless advertiser
      advertiser = self.create(image_url: auth_hash['info']['image'], uid: auth_hash['uid'], 
                              username: auth_hash['info']['nickname'], business_name: auth_hash['info']['name'])
    end
    advertiser
  end

  #Instance Method

  def advertiser?
    true
  end

  def user?
    false
  end
  
  def not_create_deal?(deal_id)
    !self.deals.map { |d| d.id }.index(deal_id.to_i)
  end
  
end
