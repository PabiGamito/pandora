class TranscationChangeInt < ActiveRecord::Migration
  def change
    remove_column :companies, :amount, :integer
    add_column :companies, :amount, :float
  end
end
