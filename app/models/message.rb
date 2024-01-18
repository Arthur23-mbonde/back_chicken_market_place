class Message < ApplicationRecord

  # Active_record associations

  belongs_to :user
  belongs_to :chat_room

  ###

  after_create_commit { broadcast_append_to chat_room }

  # Confirm a participant before start private discussions (private chat room)
  before_create :confirm_participant

  def confirm_participant
    return unless chat_room.is_private
    is_participant = Participant.where(user_id: self.user.id, chat_room_id: self.chat_room.id).first
    throw :abort unless is_participant
  end

end
