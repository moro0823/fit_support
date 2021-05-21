class AddAdminPostToAdminUserId < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_posts, :admin_user_id, :string, default: 1
  end
end
