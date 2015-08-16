class AddEmployeId < ActiveRecord::Migration
  def change
    add_column :employes, :name, :string
  end
end
