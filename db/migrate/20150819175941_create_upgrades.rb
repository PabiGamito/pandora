class CreateUpgrades < ActiveRecord::Migration
  def change
    create_table :upgrades do |t|
    	t.string :description
    	t.integer :value
    end
  end
end
