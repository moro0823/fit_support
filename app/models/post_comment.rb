class PostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :post
end
