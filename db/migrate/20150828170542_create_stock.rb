class CreateStock < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
    	t.integer :company_id
    	t.integer :item_id
    	t.integer :amount
    end
  end
end
