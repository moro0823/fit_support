class Admin::AdminPostsController < ApplicationController
  def index
    @posts = current_admin_user.admin_posts.all.page(params[:page]).reverse_order
    @genres = current_admin_user.genres.all
  end

  def new
    @post = AdminPost.new
  end

  def create
    @post = AdminPost.new(post_params)
    @post.admin_user_id = current_admin_user.id
    if @post.save
      redirect_to edit_admin_post_path(@post), notice: "最終確認してよろしければ公開中に変更して更新してください"
    else
      flash.now[:alert] = '必須項目が入力されて'
      render :new
    end
  end

  def show
    @admin_post = AdminPost.find(params[:id])
    @admin_post_comment = AdminPostComment.new
    @from_admin_comment = FromAdminComment.new
    @admin_post_comments = @admin_post.admin_post_comments.all
    @from_admin_comments = @admin_post.from_admin_comments.all
    # それぞれの複数インスタンスを1つの配列にする
    @instances = @admin_post_comments | @from_admin_comments
    # 作成降順に並び替え
    @instances.sort! { |a, b| b.created_at <=> a.created_at }
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
      redirect_to admin_posts_path, alert: '投稿を削除しました'
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
