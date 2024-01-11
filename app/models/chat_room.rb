class ChatRoom < ApplicationRecord

  # A chatroom must be unique
  validates_uniqueness_of :title
  # We define public chatroom for a default chatroom
  scope :public_chat_rooms, -> { where(is_private: false) }
  after_create_commit { broadcast_append_to "chat_rooms" }

  has_many :messages

end
