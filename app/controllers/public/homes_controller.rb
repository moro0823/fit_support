class Public::HomesController < ApplicationController

  def top
    @posts = AdminPost.where(is_show: true).page(params[:page]).reverse_order
  end

  def about
  end


  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.username = "ゲスト"
    end
    sign_in customer
    redirect_to customer_path(current_customer), notice: 'ゲストユーザーとしてログインしました。'
  end

  def guest_admin_sign_in
    admin = AdminUser.find_or_create_by!(email: 'admin@admin.com') do |admin|
      admin.password = "admintest"
    end
    sign_in admin
    redirect_to root_path, notice: '管理者としてログインしました'
  end

end
