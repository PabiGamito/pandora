class ChangeSaleryInt < ActiveRecord::Migration
  def change
    remove_column :employes, :salery, :boolean
    add_column :employes, :salery, :integer
  end
end
