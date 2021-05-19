class Admin::GenresController < ApplicationController
  def index
    @admin_user = current_admin_user
    @genres = @admin_user.genres.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.admin_user_id = current_admin_user.id
    @genre.save
    redirect_back(fallback_location: root_path)
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @posts = @genre.admin_posts.all.page(params[:page]).per(5).reverse_order
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: '変更しました'
    else
      flash.now[:alert] = '変更できませんでした'
      redirect_to admin_genres_path
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.destroy
      redirect_to admin_genres_path, alert: '投稿を削除しました'
    else
      flash.now[:alert] = '削除できませんでした'
      redirect_to admin_genres_path
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
