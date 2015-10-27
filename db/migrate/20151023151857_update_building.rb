class UpdateBuilding < ActiveRecord::Migration
  def change
  	remove_column :buildings, :location, :string
  	remove_column :buildings, :production, :interger
  	remove_column :buildings, :production_amount, :interger
  	add_column :buildings, :updated_at, :datetime
  end
end
