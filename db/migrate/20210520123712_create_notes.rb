class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :karute_id
      t.string :author
      t.text :menu
      t.text :comment
      t.text :eat
      t.string :weight
      t.datetime :start_time
      t.timestamps
    end
  end
end
