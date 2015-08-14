class ReplaceTransactionType < ActiveRecord::Migration
  def change
    remove_column :transactions, :type, :string
    add_column :transactions, :category, :string

  end
end
