class AddTimestampToOffers < ActiveRecord::Migration
  def change
  	add_column :sell_requests, :created_at, :datetime
    add_column :sell_requests, :updated_at, :datetime
    add_column :buy_requests, :created_at, :datetime
    add_column :buy_requests, :updated_at, :datetime
  end
end
