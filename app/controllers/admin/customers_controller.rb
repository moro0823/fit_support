class Admin::CustomersController < ApplicationController
  
  def index
    @customer = Customer.all
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
end
