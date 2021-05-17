class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :customer_id
      t.integer :room_id
      t.string :message

      t.timestamps
    end
  end
end
