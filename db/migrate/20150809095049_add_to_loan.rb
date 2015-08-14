class AddToLoan < ActiveRecord::Migration
  def change
    add_column :lenders, :total_repayed, :float
  end
end
