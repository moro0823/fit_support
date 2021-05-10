class CreateAdminPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_posts do |t|
      t.integer "genre_id"
      t.string "title"
      t.string "image_id"
      t.string "youtube_url"
      t.text "body"
      t.boolean "is_show", default: false
      t.timestamps
    end
  end
end
