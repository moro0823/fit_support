class RenameDayColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :day, :title
  end
end
