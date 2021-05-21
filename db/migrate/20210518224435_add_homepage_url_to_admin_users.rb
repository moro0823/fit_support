class AddHomepageUrlToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :homepage_url, :string
  end
end
