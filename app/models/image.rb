class Image < ActiveRecord::Base
  
  attr_accessible :image_url, :advertiser_id
  
  #Associations
  has_many :deals
  
end
