class AdminPost < ApplicationRecord
  belongs_to :genre
  attachment :image
  has_many :admin_post_comments, dependent: :destroy
  has_many :from_admin_comments, dependent: :destroy
  belongs_to :admin_user

  validates :title, presence: true
  validates :body, presence: true
end
