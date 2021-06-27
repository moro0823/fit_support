class Post < ApplicationRecord
  belongs_to :customer
  enum status: { "トレーニングメニュー": 0, "食事": 1, "情報の共有": 2 }
  attachment :image

  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer

  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: ["トレーニングメニュー", "食事", "情報の共有"] }
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  #ランキング機能 TOP3を抽出
  def self.posts_training_top3
      Post.where(status: "トレーニングメニュー").joins(:favorites).group("favorites.post_id").order("count(favorites.post_id) desc").limit(3)
      #Post.joins(:favorite) => いいねのついた投稿を取得
      #Post.joins(:favorite).group("favorites.post_id").count => {favorites.post_id => favorites.post_idに存在したfavoritesのレコード数}
      #.order("count(favorites.post_id) desc") => favorites.post_idに存在したfavoritesのレコード数の多い順に並び替え
  end

  def self.posts_eat_top3
    Post.where(status: "食事").joins(:favorites).group("favorites.post_id").order("count(favorites.post_id) desc").limit(3)
  end

  def self.posts_info_top3
    Post.where(status: "情報の共有").joins(:favorites).group("favorites.post_id").order("count(favorites.post_id) desc").limit(3)
  end



end
