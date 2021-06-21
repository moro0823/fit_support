class Public::HomesController < ApplicationController
  def top
    @admin_user = AdminUser.last(4).reverse
  end

  def about
  end

  def admin_posts
    @my_fitness_places = current_customer.my_fitness_places
  end

  #トップページを登録施設一覧に変更した為、現在は使用していない
  def admin_posts_show
    @genre = Genre.find(params[:genre_id])
    @posts = @genre.admin_posts.where(is_show: true).page(params[:page]).reverse_order
  end

  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.username = "ゲスト"
    end
    sign_in customer
    redirect_to customer_path(current_customer), notice: 'ゲストユーザーとしてログインしました。'
  end

  def ather_guest_sign_in
    customer = Customer.find_or_create_by!(email: 'ather_guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.username = "アザーゲスト"
    end
    sign_in customer
    redirect_to customer_path(current_customer), notice: 'アザーゲストユーザーとしてログインしました。'
  end

  def guest_admin_sign_in
    admin = AdminUser.find_or_create_by!(email: 'admin@admin.com') do |admin|
      admin.password = "admintest"
    end
    sign_in admin
    redirect_to admin_top_path, notice: '「Fit Support」管理者としてログインしました'
  end

  def ather_guest_admin_sign_in
    admin = AdminUser.find_or_create_by!(email: 'ather_admin@admin.com') do |admin|
      admin.password = "admintest2"
    end
    sign_in admin
    redirect_to admin_top_path, notice: '「WorkOuter」 管理者としてログインしました'
  end
end
