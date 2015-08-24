class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :category
      t.integer :company_id
      t.float :amount
    end
  end
end
