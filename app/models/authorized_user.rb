class AuthorizedUser
  
  def initialize(uid)
    @uid = uid
  end
  
  def current_authorized_user
   Advertiser.find_by_uid(@uid) || User.find_by_uid(@uid)
  end
    
end