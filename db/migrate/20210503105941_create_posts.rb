class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.string :day
      t.string :image_id
      t.text :body
      t.integer :status, null: false

      t.timestamps
    end
  end
end
