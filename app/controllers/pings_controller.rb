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
      redirect_back fallback_location: root_path
    end
  end

  def update
    ping = Ping.find(params[:id])
    if ping_params[:read_at]
      ping.update(read_at: DateTime.now)
      redirect_back fallback_location: root_path
    end
  end

  def mark_all_as_read
    Ping.where(recipient: current_user, read_at: nil).update_all read_at: DateTime.now
    redirect_back fallback_location: root_path
  end

  private
    def ping_params
      params.require(:ping).permit(:recipient_id, :read_at)
    end
end

