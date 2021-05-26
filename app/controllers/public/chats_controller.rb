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
    @room = @chat.room
    #チャットが投稿された部屋
    if @chat.save
      @room_member_not_me = CustomerRoom.where(room_id: @room.id).where.not(customer_id: current_customer.id)
      # チャットが投稿された部屋から自分以外のトーク部屋を抽出
      @theid = @room_member_not_me.find_by(room_id: @room.id)
      # チャットが投稿された自分以外のトーク部屋からチャットが投稿された部屋を抽出することで相手のトーク部屋を特定する
      @notification = current_customer.active_notifications.new(
        room_id: @room.id,
        chat_id: @chat.id,
        visited_id: @theid.customer_id,
        visitor_id: current_customer.id,
        action: 'message'
      )
      if @notification.visitor_id == @notification.visited_id
        @notification.checked = true
        #自分が送ったチャットは、通知済みとする
      end
        @notification.save if @notification.valid?
        redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id, :customer_id).merge(customer_id: current_customer)
  end
end
