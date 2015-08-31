class AddTimeToUpgrade < ActiveRecord::Migration
  def change
  	add_column :upgrades, :time, :integer
    add_column :upgrade_levels, :updated_at, :datetime
  end
end
