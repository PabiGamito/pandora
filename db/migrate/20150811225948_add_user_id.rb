class AddUserId < ActiveRecord::Migration
  def change
    remove_column :transactions, :amount, :integer
    remove_column :companies, :amount, :float
    add_column :transactions, :amount, :float
    add_column :transactions, :user_id, :integer
  end
end
