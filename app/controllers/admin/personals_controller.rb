class Admin::PersonalsController < ApplicationController
  def create
    @personal = Personal.new(personal_params)
    if @personal.save
      redirect_to admin_staff_path(@personal.staff.id), notice: '登録しました'
    else
      flash[:alert] = 'すでに登録済みです'
      redirect_to admin_customers_path
    end
  end

  def destroy
    @personal = Personal.find(params[:id])
    if @personal.destroy
      redirect_to admin_staff_path(@personal.staff.id), alert: 'ユーザー登録を解除しました'
    else
      flash[:alert] = '削除できませんでした'
      redirect_to admin_staff_path(@personal.staff.id)
    end
  end

  private

  def personal_params
    params.require(:personal).permit(:customer_id, :staff_id)
  end
end
