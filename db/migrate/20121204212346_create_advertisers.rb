class CreateAdvertisers < ActiveRecord::Migration
  def change
    create_table :advertisers do |t|
      t.string :username
      t.string :uid
      t.string :image_url

      t.timestamps
    end
  end
end
