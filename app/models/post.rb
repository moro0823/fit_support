class Post < ApplicationRecord
  belongs_to :customer
  enum status: { "トレーニングメニュー": 0, "食事": 1,"情報の共有":2}
  attachment :image

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  validates :day, presence: true
  validates :body, presence: true
  validates :status, inclusion:{in: ["トレーニングメニュー", "食事","情報の共有"]}
end
