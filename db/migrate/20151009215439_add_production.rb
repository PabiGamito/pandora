class AddProduction < ActiveRecord::Migration
  def change
  	add_column :companies, :production, :integer
  	add_column :buildings, :production_amount, :integer
  end
end
