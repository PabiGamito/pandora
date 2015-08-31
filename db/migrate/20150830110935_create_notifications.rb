class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :company_id
    	t.integer :user_id
    	t.boolean :global
    	t.string :notification
    end
  end
end
