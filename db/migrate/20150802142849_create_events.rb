class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :name
      t.datetime :event_date
      t.integer :host_id
      t.timestamp 
      t.integer :public
      t.float :latitude
      t.float :longitude
      t.integer :activity_id
    end
    
  end
  
  def down
    drop_table :events
  end 
end
