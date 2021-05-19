class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :from_admin_comments, dependent: :destroy
  has_many :genres
  has_many :admin_posts
  attachment :image

  has_many :my_fitness_places, dependent: :destroy


  def record_by?(customer)
    my_fitness_places.where(customer_id: customer.id).exists?
  end

end
