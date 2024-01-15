class ChatRoom < ApplicationRecord

  # A chatroom must be unique
  validates_uniqueness_of :title
  # We define public chatroom for a default chatroom
  scope :public_chat_rooms, -> { where(is_private: false) }
  after_create_commit { broadcast_if_public }

  has_many :messages
  has_many :participants, dependent: :destroy

  def broadcast_if_public
    broadcast_append_to "chat_rooms" unless self.is_private
  end

  def self.create_private_chat_room(users, chat_room_title)
    single_chat_room = ChatRoom.create(title: chat_room_title, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, chat_room_id: single_chat_room.id)
    end
    single_chat_room
  end

  def participant?(chat_room, user)
    chat_room.participants.where(user: user).exists?
    Participant.where(user_id: user.id, chat_room_id: chat_room.id).exists?
  end

end
