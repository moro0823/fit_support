class Admin::MyFitnessPlacesController < ApplicationController
  def create
    @admin_user = AdminUser.find(params[:admin_user_id])
    @my_fitness_place = MyFitnessPlace.new(admin_user_id: @admin_user.id)
    @my_fitness_place.customer_id = current_customer.id
    @my_fitness_place.save!
    redirect_to customer_path(current_customer)
  end

  def destroy
    @admin_user = AdminUser.find(params[:admin_user_id])
    @my_fitness_place = current_customer.my_fitness_places.find_by(admin_user_id: @admin_user.id)
    @my_fitness_place.destroy
    redirect_back(fallback_location: root_path)
  end
end
