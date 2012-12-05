class AuthorizedUser
  
  def self.current_authorized_user(uid)
    advertiser = Advertiser.find_by_uid(uid)
    unless advertiser
      user = User.find_by_uid(uid)
    end
    return advertiser || user
  end
    
end