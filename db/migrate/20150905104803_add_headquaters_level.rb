class AddHeadquatersLevel < ActiveRecord::Migration
  def change
  	add_column :upgrades, :headquaters_level, :integer
  end
end
