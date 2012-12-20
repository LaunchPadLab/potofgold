class AuthorizedUser
  
  def initialize(uid)
    @uid = uid
  end
  
  def current_authorized_user
   User.find_by_uid(@uid) || Advertiser.find_by_uid(@uid)
  end
    
end