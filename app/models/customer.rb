class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  enum sex: { "男性": 0, "女性": 1}
  validates :username, presence: true
  has_many :posts, dependent: :destroy
  has_many :post_comments,dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post


  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

end
