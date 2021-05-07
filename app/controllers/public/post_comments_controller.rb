class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_customer.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    @comment.save
    @comments = @post.post_comments.all.page(params[:page]).per(5)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @comments = @post.post_comments.all.page(params[:page]).per(5)
  end

  def show
   
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
