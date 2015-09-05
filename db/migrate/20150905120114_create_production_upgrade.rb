class CreateProductionUpgrade < ActiveRecord::Migration
  def change
    create_table :upgrade_productions do |t|
    	t.integer :max_employees
    	t.float :speed_per_employee
    	t.integer :employees
    	t.integer :upgrade_id
    end
  end
end
