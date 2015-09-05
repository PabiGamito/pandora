class AddTimestampBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :created_at, :datetime
  end
end
