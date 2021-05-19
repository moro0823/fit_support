class MyFitnessPlace < ApplicationRecord
  belongs_to :customer
  belongs_to :admin_user
end
