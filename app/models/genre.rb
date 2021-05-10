class Genre < ApplicationRecord
  has_many :admin_posts, dependent: :destroy
end
