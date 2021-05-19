class Personal < ApplicationRecord
  belongs_to :customer
  belongs_to :staff
end
