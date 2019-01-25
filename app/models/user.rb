class User < ApplicationRecord
  include Clearance::User
  has_many :pings, foreign_key: :recipient_id

  def username
    email.split('@').first
  end

  # TESTME
  def unread_pings
    self.pings.where(read_at: nil).order(created_at: :desc)
  end

  def presence_status
    if online?
      'online'
    elsif away?
      'away'
    else
      'offline'
    end
  end

  def online?
    signed_in? && last_seen_at >= 5.minutes.ago
  end

  def away?
    signed_in? &&
    last_seen_at >= 15.minutes.ago && last_seen_at < 5.minutes.ago
  end

  def offline?
    !signed_in? || signed_in? && last_seen_at < 15.minutes.ago
  end

  def appear
    update_column(:signed_in, true) unless signed_in?
    ActionCable.server.broadcast('presence_channel', user_id: id, online: true, username: username)
  end

  def disappear
    update_column(:signed_in, false) if signed_in?
    ActionCable.server.broadcast('presence_channel', user_id: id, online: false, username: username)
  end
end
