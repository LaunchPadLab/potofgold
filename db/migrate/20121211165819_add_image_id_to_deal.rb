class AddImageIdToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :image_id, :integer
  end
end
