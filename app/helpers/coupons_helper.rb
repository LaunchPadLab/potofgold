module CouponsHelper

	def print_redeemed(coupon)
	  if coupon.redeemed?
	    'Redeemed!'
    elsif coupon.expired?
      'Expired!'
    else
      'Not yet...'
    end
	end

end
