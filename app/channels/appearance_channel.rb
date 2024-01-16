class AppearanceChannel < ApplicationCable::Channel

  def subscribed
    # if current_user is subscribed, he's online if he's in the home page
    stream_from "appearance_channel"

    # current_user.update(status: User.statuses[:online])

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # if the current_user is unsubscribed, he's just offline
    stop_stream_from 'appearance_channel'
    offline
  end

  def online
    status = User.statuses[:online]
    broadcast_new_status(status)
  end

  def away
    status = user.statuses[:away]
    broadcast_new_status(status)
  end

  def offline
    status = User.statuses[:offline]
    broadcast_new_status(status)
  end

  def receive(data)
    ActionCable.server.broadcast('appearance_channel', data)
  end

  private

  def broadcast_new_status(status)
    current_user.update!(status: status)
  end

end
