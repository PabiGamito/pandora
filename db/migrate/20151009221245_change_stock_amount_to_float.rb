class ChangeStockAmountToFloat < ActiveRecord::Migration
  def change
  	remove_column :stocks, :amount, :integer
  	add_column :stocks, :amount, :float
  end
end
