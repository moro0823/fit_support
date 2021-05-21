class Staff < ApplicationRecord
  belongs_to :admin_user
  has_many :personals, dependent: :destroy
  has_many :karutes, dependent: :destroy

  def recorded_by?(customer)
    personals.where(customer_id: customer.id).exists?
  end
end
