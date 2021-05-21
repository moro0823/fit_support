class Admin::NotesController < ApplicationController
  def new
    @karute = params[:karute_id]
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to admin_karute_path(@note.karute_id), notice: "記録しました！"
    else
      flash[:alert] = '記録に失敗しました'
      render "new"
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to admin_karute_note_path(karute_id: @note.karute, id: @note), notice: "更新しました"
    else
      flash[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      redirect_to admin_karute_path(@note.karute_id), alert: '削除しました'
    else
      flash[:alert] = '削除できませんでした'
      redirect_to admin_karute_path(@post)
    end
  end

  private

  def note_params
    params.require(:note).permit(:karute_id, :author, :menu, :comment, :eat, :weight, :start_time)
  end
end
