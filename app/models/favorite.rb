class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :customer_id
  # 　一つの投稿に一人一つしかいいねがつけれない
end
