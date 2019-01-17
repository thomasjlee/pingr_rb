class PingsController < ApplicationController
  before_action :require_login

  def index
    @pings = Ping.where(recipient: current_user, read_at: nil)
  end

  def archive
    @read_pings = Ping.where(recipient: current_user).where.not(read_at: nil)
  end
end

