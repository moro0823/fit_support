class Public::FavoritesController < ApplicationController
  def create
    @favorite = current_customer.favorites.new(post_id: params[:post_id])
    @favorite.save
    redirect_back(fallback_location: root_path)
    #直前のページに戻るように
  end

  def destroy
    @favorite = Favorite.find_by(post_id: params[:post_id], customer_id: current_customer.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    @favorites = current_customer.favorites.all
  end

end
