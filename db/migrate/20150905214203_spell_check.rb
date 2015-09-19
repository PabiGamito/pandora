class SpellCheck < ActiveRecord::Migration
  def change
  	add_column :upgrades, :headquarters_level, :integer
  	remove_column :upgrades, :headquaters_level, :integer
  end
end
