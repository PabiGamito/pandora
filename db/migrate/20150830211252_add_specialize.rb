class AddSpecialize < ActiveRecord::Migration
  def change
  	add_column :companies, :specialize, :integer
  end
end
