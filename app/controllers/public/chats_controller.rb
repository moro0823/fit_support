class Public::ChatsController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @rooms = current_customer.customer_rooms.pluck(:room_id)
    @customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: @rooms)
    # ここまでで、ログインしているユーザーとマイページを表示しているユーザーとの間にチャット部屋があるかを調べる

    if @customer_rooms.nil? # チャット部屋がない場合は部屋を新しく作成する
      @room = Room.new
      @room.save
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
    else
      @room = @customer_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    @chat.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
