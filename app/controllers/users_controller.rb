class UsersController < ApplicationController
  def index
    if signed_in?
      @users = User.where.not(id: current_user.id)
    else
      @users = User.all
    end
  end
end
