class Admin::PersonalsController < ApplicationController

  def create
    @personal = Personal.new(personal_params)
    if @personal.save
      redirect_to admin_staff_path(@personal.staff.id), notice: '登録しました'
    else
      flash.now[:alert] = '登録できませんでした'
      redirect_to admin_customers_path
    end
  end


  def destroy
  end

  private

  def personal_params
    params.require(:personal).permit(:customer_id, :staff_id)
  end
end
