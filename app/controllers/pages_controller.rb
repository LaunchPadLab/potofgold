class PagesController < ApplicationController

  def home
	if current_authorized_user
		if current_authorized_user.class.name.include?("Advertiser")
			redirect_to deals_path
		else
			redirect_to coupons_path
		end
	end
  end

end