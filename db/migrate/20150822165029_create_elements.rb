class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.float :value
      t.float :buy_price
      t.float :sell_price
    end
  end
end
