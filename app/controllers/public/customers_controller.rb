class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(@customer),notice: 'ユーザー情報を更新しました'
    else
      flash.now[:alert] = 'ユーザー情報の更新に失敗しました'
       render :edit
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:username, :email, :profile_image, :age, :height, :weight, :fat_percentage,:sex, :is_show)
  end

end
