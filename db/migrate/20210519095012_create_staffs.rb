class CreateStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :staffs do |t|
      t.text "name"
      t.integer "admin_user_id"
      t.timestamps
    end
  end
end
