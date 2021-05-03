class Public::PostsController < ApplicationController
  def index
    
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save
    redirect_to customer_path(current_customer)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to customer_path(current_customer), notice: "更新しました"
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to customer_path(current_customer), alert:  '投稿を削除しました'
    else
      flash.now[:alert] = '削除できませんでした'
      redirect_to customer_path(current_customer)
    end
  end

  private

    def post_params
      params.require(:post).permit(:customer_id, :day, :image, :body, :status)
    end

end
