class AddPriceToUpgrade < ActiveRecord::Migration
  def change
  	add_column :upgrades, :price, :integer
  	create_table :upgrade_recepies do |t|
    	t.integer :upgrade_id
    	t.integer :item_id
    	t.integer :amount
    end
  end
end
