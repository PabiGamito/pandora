class AddSharePrice < ActiveRecord::Migration
  def change
  	add_column :companies, :share_price, :float
  end
end
