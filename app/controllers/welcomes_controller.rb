class WelcomesController < ApplicationController

  after_action :set_status

  def index
    @users = User.all
  end

  private

  def set_status
    current_user.update!(status: User.statuses[:offline]) if current_user
  end

end
