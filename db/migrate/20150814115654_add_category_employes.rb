class AddCategoryEmployes < ActiveRecord::Migration
  def change
    add_column :employes, :category, :string
  end
end
