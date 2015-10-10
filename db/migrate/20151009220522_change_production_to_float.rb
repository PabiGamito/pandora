class ChangeProductionToFloat < ActiveRecord::Migration
  def change
  	remove_column :companies, :production, :integer
  	add_column :companies, :production, :float
  	remove_column :buildings, :production_amount, :integer
  	add_column :buildings, :production_amount, :float
  end
end
