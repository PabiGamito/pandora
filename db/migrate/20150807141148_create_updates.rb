class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :message
    end

    add_column :users, :premium, :boolean

  end
end
