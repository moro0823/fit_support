class Admin::AdminUsersController < ApplicationController

  def top
    @admin_user = current_admin_user
  end

  def show
    @admin_user = AdminUser.find(params[:id])
  end

  def index
    @admin_users = AdminUser.all.page(params[:page])
  end

  def edit
    @admin_user = current_admin_user
  end

  def update
    @admin_user = current_admin_user
    if @admin_user.update(admin_user_params)
      redirect_to admin_top_path, notice: 'ユーザー情報を更新しました'
    else
      flash.now[:alert] = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:name, :body, :phone_number, :postal_code, :adrress, :image, :homepage_url)
  end
end
