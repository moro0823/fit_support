class Karute < ApplicationRecord
  belongs_to :customer
  belongs_to :staff
  validates :customer_id, presence: true, uniqueness: { scope: :staff_id }
  # ユーザーと担当スタッフとの間のカルテは一つ
  has_many :notes
end
