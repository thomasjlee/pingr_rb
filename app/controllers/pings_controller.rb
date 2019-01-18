class PingsController < ApplicationController
  before_action :require_login

  def index
    @pings = Ping.where(recipient: current_user, read_at: nil)
  end

  def archives
    @read_pings = Ping.where(recipient: current_user).where.not(read_at: nil)
  end

  def create
    recipient = User.find(ping_params[:recipient_id])
    ping = recipient.pings.new(pinger: current_user)
    if ping.save
      flash[:notice] = "You pinged #{recipient.email}!"
      redirect_back fallback_location: root_path
    end
  end

  private
    def ping_params
      params.require(:ping).permit(:recipient_id)
    end
end

