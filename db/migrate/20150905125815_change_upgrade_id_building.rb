class ChangeUpgradeIdBuilding < ActiveRecord::Migration
  def change
  	remove_column :upgrade_productions, :employees, :integer
    add_column :employes, :building_id, :integer
  end
end
