class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :advertiser_id
      t.datetime :end_date
      t.text :coupon_text
      t.string :sample_tweet

      t.timestamps
    end
  end
end
