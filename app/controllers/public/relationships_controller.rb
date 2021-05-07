class Public::RelationshipsController < ApplicationController

  def follow
    current_customer.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_customer.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

end
