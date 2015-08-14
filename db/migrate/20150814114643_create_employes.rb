class CreateEmployes < ActiveRecord::Migration
  def change
    create_table :employes do |t|
      t.integer :company_id
      t.float :iq
      t.integer :efficiency
      t.integer :focus
      t.string :quality
      t.integer :happiness
      t.boolean :salery
      t.string :description
      t.timestamps
    end
  end
end
