class AddRequestBooleanToEmployes < ActiveRecord::Migration
  def change
    add_column :employes, :request, :boolean
  end
end
