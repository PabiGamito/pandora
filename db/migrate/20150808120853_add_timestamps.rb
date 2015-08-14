class AddTimestamps < ActiveRecord::Migration
  def change
    add_column :loans, :created_at, :datetime
    add_column :loans, :updated_at, :datetime

    add_column :companies, :created_at, :datetime
    add_column :companies, :updated_at, :datetime

    add_column :updates, :created_at, :datetime
  end
end
