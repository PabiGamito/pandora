class AddStorageToStock < ActiveRecord::Migration
  def change
  	add_column :stocks, :storage_id, :integer
  	add_column :buildings, :break_date, :datetime
  end
end
