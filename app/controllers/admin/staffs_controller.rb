class Admin::StaffsController < ApplicationController
  def new
    @admin_user = current_admin_user
    @staff = Staff.new
    @staffs = @admin_user.staffs.all

  end

  def create
    @staff = Staff.new(staff_params)
    @staff.admin_user_id = current_admin_user.id
    @staff.save
    redirect_back(fallback_location: root_path)
    @staffs = Staff.all
  end

  def show
    @staff = Staff.find(params[:id])
    @personals = Personal.where(staff_id: @staff.id)
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])
    if @staff.update(staff_params)
      redirect_to new_admin_staff_path, notice: '変更しました'
    else
      flash.now[:alert] = '変更できませんでした'
      redirect_to edit_admin_staff_path(@staff)
    end
  end

  def destroy
    @staff = Staff.find(params[:id])
    if @staff.destroy
      redirect_to new_admin_staff_path, alert: '削除しました'
    else
      flash.now[:alert] = '削除できませんでした'
      redirect_to new_admin_staff_path
    end
  end

  private

  def staff_params
    params.require(:staff).permit(:name)
  end
end
