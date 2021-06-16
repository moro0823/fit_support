class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :training, :eat, :info]
  # ログインしなくても投稿一覧は見れるように設定
  def index
    @posts = Post.all.page(params[:page]).reverse_order
    @favorite = Favorite.new
  end

  def mypost
    @posts = current_customer.posts.all.page(params[:page]).reverse_order
  end

  def training
    @posts = Post.where(status: "トレーニングメニュー").page(params[:page]).reverse_order
  end

  def eat
    @posts = Post.where(status: "食事").page(params[:page]).reverse_order
  end

  def info
    @posts = Post.where(status: "情報の共有").page(params[:page]).reverse_order
  end

  def search
    @genre = Post.search(params[:search])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to customer_path(current_customer), notice: "投稿しました"
    else
      flash.now[:alert] = '必須項目が入力されてない為、投稿に失敗しました'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @favorite = Favorite.new
    @comments = @post.post_comments.all.page(params[:page]).per(5)
  end

  def edit
    @post = Post.find(params[:id])
    if @post.customer == current_customer
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました"
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to customer_path(current_customer), alert: '投稿を削除しました'
    else
      flash.now[:alert] = '削除できませんでした'
      redirect_to customer_path(current_customer)
    end
  end

  private

  def post_params
    params.require(:post).permit(:customer_id, :title, :body, :status, :day, post_images_images: [])
  end
end
