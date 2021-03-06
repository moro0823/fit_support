class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  # ログインしないと自分のマイページや他の人のマイページは見れないように

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.page(params[:page]).reverse_order.limit(4)
    @my_fitness_places = current_customer.my_fitness_places
    @karutes = Karute.where(customer_id: current_customer)
    @notifications = current_customer.passive_notifications.where(checked: 0)
    #未読のメッセージのみviewページに送る（マイページのメッセージがない文を表示するため）
  end

  def favorite
    @favorite_posts = current_customer.favorited_posts.page(params[:page])
  end

  def from_favorite
    @post = Post.find(params[:id])
  end

  def follower
    @customer = Customer.find_by(id: params[:customer_id])
  end

  def followed
    @customer = Customer.find_by(id: params[:customer_id])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: 'ユーザー情報を更新しました'
    else
      flash.now[:alert] = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:username, :email, :profile_image, :age, :height, :weight,
                                     :fat_percentage, :sex, :is_show, :introduction)
  end
end
