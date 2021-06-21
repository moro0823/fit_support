class Public::SearchesController < ApplicationController
  def search
    @search_params = search_params
    @customers = Customer.search(@search_params).where(is_show: true).page(params[:page])
  end

  def search_friend
    @search_friend_params = customer_search_friend_params
    @friend_customers = Customer.search_friend(@search_friend_params).page(params[:page])
  end

  def search_post
    @posts = Post.where('title LIKE ? OR body LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).reverse_order
  end

  def search_mypage_post
    @posts = Post.where("status LIKE ?", "%#{params[:search]}%").where(customer_id: current_customer).page(params[:page]).reverse_order
    @status_title = Post.find_by("status LIKE ?", "%#{params[:search]}%")
    # @posts 投稿一覧表示用 @status_title タイトル表示用
  end

  private

  def search_params
    params.fetch(:search, {}).permit(:sex, :age_from, :age_to, :height_from, :height_to,
                                     :weight_from, :weight_to, :fat_percentage_from,
                                     :fat_percentage_to)
    # fetchは指定されたキーのパラメーターを返す。
    # params[:search]が空の場合{}をparams[:search]が空でない場合、params[:search]を返す
  end

  def customer_search_friend_params
    params.fetch(:search_friend, {}).permit(:username)
  end
end
