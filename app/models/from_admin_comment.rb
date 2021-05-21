class FromAdminComment < ApplicationRecord
  belongs_to :admin_user
  belongs_to :admin_post
end
