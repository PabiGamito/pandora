class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
    	t.integer :company_id
    	t.string :name
    	t.string :location
    	t.integer :level
    end
  end
end
