class Public::FavoritesController < ApplicationController
  before_action :set_post

  def create
    @favorite = current_customer.favorites.new(post_id: @post.id)
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(post_id: @post.id, customer_id: current_customer.id)
    @favorite.destroy
  end

  def destroy_favorite
    @favorite = Favorite.find_by(post_id: @post.id, customer_id: current_customer.id)
    @favorite.destroy
    redirect_to customer_favorite_path
    # favorite.htmlで削除だけするので非同期通信に別でdestoyアクションを
  end

  def index
    @favorites = current_customer.favorites.all
  end

  private

  def set_post
    @post = Post.find_by(id: params[:post_id])
    # いいねを押した（または現在表示している）投稿情報を取得し、@postに格納
    # before_actionでcreate,destroyが行われる前にidを取得
  end
end
