class WelcomesController < ApplicationController

  def index
    @users = User.all
  end

end
