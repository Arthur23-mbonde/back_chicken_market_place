class Participant < ApplicationRecord
  # Active_record associatons

  belongs_to :user
  belongs_to :chat_room

  ###

end
