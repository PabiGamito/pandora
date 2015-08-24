class ChangeCategoryToInteger < ActiveRecord::Migration
  def change
    remove_column :ads, :category, :string
    add_column :ads, :category, :integer
  end
end
