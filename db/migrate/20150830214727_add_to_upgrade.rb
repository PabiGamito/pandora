class AddToUpgrade < ActiveRecord::Migration
  def change
  	add_column :upgrades, :category, :integer
  	add_column :upgrades, :level, :integer
  end
end
