class UsersController < ApplicationController

  def show

    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @chat_room = ChatRoom.new
    @chat_rooms = ChatRoom.public_chat_rooms
    @chat_room_title = get_title(@user, current_user)

    @single_chat_room = ChatRoom.where(title: @chat_room_title).first || ChatRoom.create_private_chat_room([@user, current_user], @chat_room_title)

    @message = Message.new
    @messages = @single_chat_room.messages.order(created_at: :asc)

    render 'chat_rooms/index'

  end

  private
  def get_title(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

end
