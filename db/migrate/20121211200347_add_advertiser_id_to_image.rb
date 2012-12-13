class AddAdvertiserIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :advertiser_id, :integer
  end
end
