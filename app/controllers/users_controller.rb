class UsersController < ApplicationController
  def index
    if signed_in?
      @users = User.where.not(id: current_user.id).order(created_at: :desc)
    else
      @users = User.all.order(created_at: :desc)
    end
  end
end
