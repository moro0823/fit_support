class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :customer_id
  # 　一つの投稿に一人一つしかいいねがつけれない
  # scope 一意性制約を決めるために使用する他のカラム
end
