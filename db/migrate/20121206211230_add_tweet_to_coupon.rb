class AddTweetToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :tweet, :string
  end
end
