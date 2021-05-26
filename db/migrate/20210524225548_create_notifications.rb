class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :room_id
      t.integer :chat_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
