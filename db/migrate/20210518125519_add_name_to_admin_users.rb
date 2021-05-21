class AddNameToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :name, :string
    add_column :admin_users, :body, :text
    add_column :admin_users, :phone_number, :string
    add_column :admin_users, :postal_code, :string
    add_column :admin_users, :adrress, :string
    add_column :admin_users, :image_id, :string
  end
end
