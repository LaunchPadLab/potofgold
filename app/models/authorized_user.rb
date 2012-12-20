class AuthorizedUser
  
  def initialize(user_id)
    @user_id = user_id
  end
  
  def current_authorized_user
   User.find_by_id(@user_id) || Advertiser.find_by_id(@user_id)
  end
  
end