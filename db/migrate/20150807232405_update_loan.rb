class UpdateLoan < ActiveRecord::Migration
  def change
    remove_column :loans, :amount, :boolean
    remove_column :loans, :pending, :boolean
    add_column :loans, :amount, :float
    add_column :loans, :pending, :float
  end
end
