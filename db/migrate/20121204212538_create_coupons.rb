class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :user_id
      t.boolean :redeemed
      t.integer :deal_id
      t.integer :followers

      t.timestamps
    end
  end
end
