class AdminPostComment < ApplicationRecord
  belongs_to :customer
  belongs_to :admin_post
end
