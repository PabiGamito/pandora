class EditLender < ActiveRecord::Migration
  def change
    remove_column :lenders, :loan, :integer
    add_column :lenders, :loan_id, :integer
  end
end
