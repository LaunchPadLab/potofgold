class AddFollowersCountToAdvertiser < ActiveRecord::Migration
  def change
    add_column :advertisers, :followers_count, :integer
  end
end
