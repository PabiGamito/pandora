class ChangeNameUpgrade < ActiveRecord::Migration
  def change
  	remove_column :upgrades, :description, :string
    add_column :upgrades, :name, :string
  end
end
