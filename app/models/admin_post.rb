class AdminPost < ApplicationRecord
  belongs_to :genre
  attachment :image

  validates :title, presence: true
  validates :body, presence: true

end
