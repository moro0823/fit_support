class Genre < ApplicationRecord
  has_many :admin_posts, dependent: :destroy
  belongs_to :admin_user
end
