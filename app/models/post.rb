class Post < ApplicationRecord
  belongs_to :customer
  enum status: { "トレーニングメニュー": 0, "食事": 1,"情報の共有":2}
  attachment :image 
end
