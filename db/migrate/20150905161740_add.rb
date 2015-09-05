class Add < ActiveRecord::Migration
  def change
  	add_column :buildings, :production, :boolean
  end
end
