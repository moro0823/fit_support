class CreateAdminPostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_post_comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :admin_post_id

      t.timestamps
    end
  end
end
