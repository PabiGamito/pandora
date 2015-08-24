class CategoryToInt < ActiveRecord::Migration
  def change
    remove_column :employes, :category, :string
    add_column :employes, :category, :integer
  end
end
