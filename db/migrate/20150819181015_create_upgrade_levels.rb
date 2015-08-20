class CreateUpgradeLevels < ActiveRecord::Migration
  def change
    create_table :upgrade_levels do |t|
    	t.integer :company_id
      t.integer :upgrade_value
      t.integer :level
    end
  end
end
