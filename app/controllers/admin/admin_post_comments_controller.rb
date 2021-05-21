class Admin::AdminPostCommentsController < ApplicationController
  before_action :authenticate_customer!

  def destroy
    @admin_post_comment = AdminPostComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  def create
    @admin_post = AdminPost.find(params[:admin_post_id])
    @admin_post_comment = current_customer.admin_post_comments.new(admin_post_comment_params)
    @admin_post_comment.admin_post_id = @admin_post.id
    @admin_post_comment.save
    redirect_back(fallback_location: root_path)
  end

  private

  def admin_post_comment_params
    params.require(:admin_post_comment).permit(:comment)
  end
end
