class Image < ActiveRecord::Base
  
  attr_accessible :image_url
  
  #Associations
  has_many :deals
  
end
