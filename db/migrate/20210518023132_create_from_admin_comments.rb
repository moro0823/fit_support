class CreateFromAdminComments < ActiveRecord::Migration[5.2]
  def change
    create_table :from_admin_comments do |t|
      t.text :comment
      t.integer :admin_user_id
      t.integer :admin_post_id

      t.timestamps
    end
  end
end
