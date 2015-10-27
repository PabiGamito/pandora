class AddUserIdToLender < ActiveRecord::Migration
  def change
  	add_column :lenders, :user_id, :integer
  end
end
