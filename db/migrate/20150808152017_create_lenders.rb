class CreateLenders < ActiveRecord::Migration
  def change
    create_table :lenders do |t|
      t.integer :company_id
      t.integer :loan
      t.float :percentage
      t.timestamps
    end
  end
end
