class AddBackgroundImageUrlToAdvertiser < ActiveRecord::Migration
  def change
    add_column :advertisers, :background_image_url, :string
  end
end
