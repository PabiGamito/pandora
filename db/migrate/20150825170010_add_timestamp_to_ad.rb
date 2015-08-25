class AddTimestampToAd < ActiveRecord::Migration
  def change
    add_column :ads, :created_at, :datetime
    add_column :ads, :updated_at, :datetime
  end
end
