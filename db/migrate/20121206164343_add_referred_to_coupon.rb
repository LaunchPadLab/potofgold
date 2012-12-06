class AddReferredToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :referred, :boolean
  end
end
