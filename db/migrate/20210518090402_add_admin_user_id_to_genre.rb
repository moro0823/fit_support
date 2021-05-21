class AddAdminUserIdToGenre < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :admin_user_id, :integer
  end
end
