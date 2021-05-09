class Admin::CustomersController < ApplicationController

  def index
    @search_admin_customers_params = customer_search_admin_params
    @search_admin_customers = Customer.search_admin_customer(@search_admin_customers_params)
  end

  #投稿一覧表示
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all.page(params[:page]).reverse_order
  end

  def post
    @posts = Post.all.page(params[:page]).reverse_order
  end

  private

  def customer_search_admin_params
    params.fetch(:search_admin_customer, {}).permit(:username)
  end

end
