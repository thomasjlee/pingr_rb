class PingsController < ApplicationController
  before_action :require_login

  def index
    @pings = Ping.where(recipient: current_user, read_at: nil)
    # @pings = current_user.pings.where(read_at: nil)
  end
end

