class Post < ApplicationRecord
  belongs_to :customer
  enum status: { "トレーニングメニュー": 0, "食事": 1,"情報の共有":2}
  attachment :image

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer

  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion:{in: ["トレーニングメニュー", "食事","情報の共有"]}
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
end

