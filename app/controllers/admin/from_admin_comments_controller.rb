class Admin::FromAdminCommentsController < ApplicationController
  before_action :authenticate_admin_user!

  def destroy
    @from_admin_comment = FromAdminComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  def create
    @admin_post = AdminPost.find(params[:admin_post_id])
    @from_admin_comment = current_admin_user.from_admin_comments.new(from_admin_comment_params)
    @from_admin_comment.admin_post_id = @admin_post.id
    @from_admin_comment.save
    redirect_back(fallback_location: root_path)
  end

  private

  def from_admin_comment_params
    params.require(:from_admin_comment).permit(:comment)
  end
end
