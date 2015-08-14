class UpdateUser < ActiveRecord::Migration
  def up
    add_column :users, :balance, :float
    add_column :users, :full_name, :string
  end
  def down
    remove_column :users, :balance, :float
    remove_column :users, :full_name, :string
  end
end
