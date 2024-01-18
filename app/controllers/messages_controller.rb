class MessagesController < ApplicationController

  # This partial of code will create an user's messages
  def create
    @message = current_user.messages.create(content: message_params[:content], chat_room_id: params[:chat_room_id])
  end

  private

   def message_params
      params.require(:message).permit(:content)
   end

end
