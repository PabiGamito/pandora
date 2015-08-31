class CreateSellRequest < ActiveRecord::Migration
  def change
    create_table :sell_requests do |t|
    	t.integer :company_id
    	t.integer :item_id
    	t.integer :amount
    	t.boolean :share
    	t.float :price
    end
    create_table :buy_request do |t|
    	t.integer :company_id
    	t.integer :amount
    	t.boolean :share
    	t.integer :item_id
    	t.float :price
    end
    rename_table(:elements, :items)
    add_column :items, :price, :float
    remove_column :items, :sell_price, :float
    remove_column :items, :buy_price, :float
  end
end
