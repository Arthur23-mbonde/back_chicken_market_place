class ChatRoomsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_status

  def index

    @chat_room = ChatRoom.new

    # This code instances chat rooms and users without current user
    @chat_rooms = ChatRoom.public_chat_rooms
    @users = User.all_except(current_user)

  end

  def show

    # Find a private chat room
    @single_chat_room = ChatRoom.find(params[:id])

    # Define and fix a public chat room
    @chat_room = ChatRoom.new
    @chat_rooms = ChatRoom.public_chat_rooms

    # Define and fix messages in the chat room
    @message = Message.new
    @messages = @single_chat_room.messages.order(created_at: :asc)

    # All users except the current user
    @users = User.all_except(current_user)

    render 'index'

  end

  def create
    @chat_room = ChatRoom.create(title: params['title'])
  end

  private

  def set_status
    current_user.update!(status: User.statuses[:online]) if current_user
  end

end
