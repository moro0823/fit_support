class Admin::AdminPostsController < ApplicationController

  def index
    @posts = AdminPost.all.page(params[:page]).reverse_order
    @genres = Genre.all
  end

  def new
    @post = AdminPost.new
  end

  def create
    @post = AdminPost.new(post_params)
    if @post.save
      redirect_to edit_admin_post_path(@post), notice: "最終確認してよろしければ公開中に変更して更新してください"
    else
      flash.now[:alert] = '必須項目が入力されて'
      render :new
    end
  end

  def show
    @post = AdminPost.find(params[:id])
  end

  def edit
    @post = AdminPost.find(params[:id])
  end

  def update
    @post = AdminPost.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "更新しました"
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @post = AdminPost.find(params[:id])
    if @post.destroy
      redirect_to admin_posts_path, alert:  '投稿を削除しました'
    else
      flash.now[:alert] = '削除できませんでした'
      redirect_to admin_post_path(@post)
    end
  end

  private

    def post_params
      params.require(:admin_post).permit(:genre_id, :title, :image, :body, :youtube_url, :is_show)
    end

end