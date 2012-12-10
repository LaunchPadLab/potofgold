class AddBusinessNameToAdvertiser < ActiveRecord::Migration
  def change
    add_column :advertisers, :business_name, :string
  end
end
