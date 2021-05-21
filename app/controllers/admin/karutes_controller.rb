class Admin::KarutesController < ApplicationController

  def create
    @karute = Karute.new(karute_params)
    if @karute.save
      redirect_to admin_karute_path(@karute), notice: "カルテを作成しました"
    else
      flash[:alert] = '作成に失敗しました'
      redirect_to admin_staff_path(@karute.staff_id)
    end
  end

  def show
    @karute = Karute.find_by(id: params[:id])
    @notes = @karute.notes
  end

  def edit
    @karute = Karute.find(params[:id])
  end

  def update
    @karute = Karute.find(params[:id])
    if @karute.update(karute_params)
      redirect_to admin_karute_path(@karute), notice: "更新しました"
    else
      flash[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  private

  def karute_params
    params.require(:karute).permit(:customer_id, :staff_id, :customer_name, :staff_name, :next_goal, :goal, :memo)
  end

end
