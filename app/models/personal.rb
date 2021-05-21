class Personal < ApplicationRecord
  belongs_to :customer
  belongs_to :staff
  validates :customer_id, presence: true, uniqueness: { scope: :staff_id }
end
