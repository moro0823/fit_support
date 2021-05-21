class CreateKarutes < ActiveRecord::Migration[5.2]
  def change
    create_table :karutes do |t|
      t.integer :customer_id
      t.integer :staff_id
      t.string :customer_name
      t.string :staff_name
      t.text :next_goal
      t.text :goal
      t.string :memo
      t.timestamps
    end
  end
end
