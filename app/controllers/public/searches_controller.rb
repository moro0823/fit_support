class Public::SearchesController < ApplicationController
  def search
    @search_params = customer_search_params
    @customers = Customer.search(@search_params).where(is_show: true)
  end


  private

  def customer_search_params
    params.fetch(:search, {}).permit(:sex, :age_from, :age_to, :height_from, :height_to, :weight_from, :weight_to, :fat_percentage_from, :fat_percentage_to )
  end

end
